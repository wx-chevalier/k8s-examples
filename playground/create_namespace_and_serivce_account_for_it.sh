#!/usr/bin/env bash

# 
# 针对集群创建新的用户与命名空间
#
# namespace you want to create
NAMESPACE=<namespace>

# cluster configuration
CLUSTER_SERVER=https://<your-cluster-endpoint>
CLUSTER_NAME=<your-cluster-name>

# customize these names as needed
ACCOUNT=${NAMESPACE}-admin
ROLE_NAME=${NAMESPACE}-full-access
ROLE_BINDING_NAME=${NAMESPACE}-view

## Create namespace & access resources
echo "---
apiVersion: v1
kind: Namespace
metadata:
  name: ${NAMESPACE}

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: \"${ACCOUNT}\"
  namespace: \"${NAMESPACE}\"

---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: \"${ROLE_NAME}\"
  namespace: \"${NAMESPACE}\"
rules:
- apiGroups: [\"\", \"extensions\", \"apps\"]
  resources: [\"*\"]
  verbs: [\"*\"]
- apiGroups: [\"batch\"]
  resources:
  - jobs
  - cronjobs
  verbs: [\"*\"]

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: \"${ROLE_BINDING_NAME}\"
  namespace: \"${NAMESPACE}\"
subjects:
- kind: ServiceAccount
  name: \"${ACCOUNT}\"
  namespace: \"${NAMESPACE}\"
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: \"${ROLE_NAME}\"
" > ${NAMESPACE}.yaml
kubectl apply -f ${NAMESPACE}.yaml

## Create access configuration
SECRET=$(kubectl get sa ${ACCOUNT} -n ${NAMESPACE} -o "jsonpath={.secrets[0].name}")
TOKEN=$(kubectl get secret ${SECRET} -n ${NAMESPACE} -o "jsonpath={.data.token}" | base64 -d)
CERT=$(kubectl get secret ${SECRET} -n ${NAMESPACE} -o "jsonpath={.data['ca\.crt']}")

echo "Creating kube_config-${NAMESPACE}.yaml"
echo "
apiVersion: v1
kind: Config
preferences: {}

# Define the cluster
clusters:
  - cluster:
      certificate-authority-data: $CERT
      server: \"${CLUSTER_SERVER}\"
    name: \"${CLUSTER_NAME}\"

# Define the user
users:
- name: \"${ACCOUNT}\"
  user:
    as-user-extra: {}
    client-key-data: \"${CERT}\"
    token: \"${TOKEN}\"

# Define the context: linking a user to a cluster
contexts:
- context:
    cluster: \"$[CLUSTER_NAME]\"
    namespace: \"${NAMESPACE}\"
    user: \"${ACCOUNT}\"
  name: \"${NAMESPACE}\"

# Define current context
current-context: \"${NAMESPACE}\"
" > ./kube_config-${NAMESPACE}.yaml

echo
echo "    export KUBECONFIG=`pwd`/kube_config-${NAMESPACE}.yaml"
echo