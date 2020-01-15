# 使用 rke 安装 Kubernetes 集群

依次在每台机器上安装 docker，保证每个节点都能通过 `rancher-cluster.yml` 中的 `address` 和 `internal_address` 访问彼此的 `6443` 端口,然后执行 `rke up --config ./rancher-cluster.yml`。详细安装过程见 [How to Install Rancher on a High-availability Kubernetes Cluster](https://rancher.com/docs/rancher/v2.x/en/installation/ha/)。最终会生成两个文件：

- `kube_config_rancher-cluster.yml`: [Kubeconfig file](https://rancher.com/docs/rke/latest/en/kubeconfig/)
- `rancher-cluster.rkestate`: [Kubernetes Cluster State file](https://rancher.com/docs/rke/latest/en/installation/#kubernetes-cluster-state)

# 使用 kubectl 管理集群

1. 添加集群配置
2. 添加用户
3. 添加 context

详情见 [Configure Access to Multiple Clusters](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).

## 添加集群配置

集群 cert 的 base64 值存放在 `kube_config_rancher-cluster.yml` 的 `clusters > cluster > certificate-authority-data` 下，解码生成 cert 文件（[base64 解码](#ref-base64-decoding)）。

添加集群配置：

```sh
kubectl config set-cluster yourbiz --server=https://youadress:6443 --certificate-authority=/path/to/cluster.crt
```

可以通过 `kubectl config view` 查看是否配置成功。

## 添加 yourbiz 集群管理员账户

`kube_config_rancher-cluster.yml` 中 `users > user` 下 `client-certificate-data` 和 `client-key-data` 分别存放了用户的 cert 和 key 的 base64 值，解码生成对应的文件（[base64 解码](#ref-base64-decoding)）。

添加账户配置，并添加一个 context，使用该账户作为该 context 的账户：

```sh
kubectl config set-credentials kube-admin-yourbiz \
        --client-certificate=/path/to/admin.crt \
        --client-key=/path/to/admin.key

kubectl config set-context yourbiz --cluster=yourbiz --user=kube-admin-yourbiz
```

使用：

```sh
kubectl config use-context yourbiz

# 设定默认命名空间
kubectl config set-context --current --namespace rabbitmq

kubectl get nodes
```

## 创建并使用其它账户

> https://kubernetes.io/docs/reference/access-authn-authz/authorization/

以创建一个新的命名空间，并创建拥有该命名空间下所有权限的账户为例：

- 创建命名空间，`kubectl apply -f yourbiz-dev-ns.yaml`

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: yourbiz-dev
```

- 创建管理账户，`kubectl apply -f yourbiz-dev-admin.yaml`

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: yourbiz-dev-admin
  namespace: yourbiz-dev
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: yourbiz-dev-admin
  namespace: yourbiz-dev
rules:
  - apiGroups: ["*"]
    resources: ["*"]
    verbs: ["*"]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: yourbiz-dev-admin
  namespace: yourbiz-dev
subjects:
  - kind: ServiceAccount
    name: yourbiz-dev-admin
    namespace: yourbiz-dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: yourbiz-dev-admin
```

为该命名空间和管理账户创建一个 kubectl 的 context 方便使用：

```sh
SECRET=$(kubectl -n yourbiz-dev get serviceaccounts yourbiz-dev-admin -o 'jsonpath={.secrets[0].name}')
TOKEN=$(kubectl -n yourbiz-dev get secrets $SECRET -o 'jsonpath={.data.token}' | base64 -d)

kubectl config set-credentials yourbiz-dev-admin --token=$TOKEN

kubectl config set-context yourbiz-dev --cluster=yourbiz --user=yourbiz-dev-admin --namespace yourbiz-dev

# 测试
kubectl config use-context yourbiz-dev
kubectl get pods
```

# 参考

## <div id="ref-base64-decoding">base64 解码</div>

```
echo <base64-data> | base64 -d > /path/to/output-file
```
