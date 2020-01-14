# 安装

详情见 [Installing with Helm](https://cert-manager.io/docs/installation/kubernetes/#installing-with-helm)

```sh
helm version
# version.BuildInfo{Version:"v3.0.2", GitCommit:"19e47ee3283ae98139d98460de796c1be1e3975f", GitTreeState:"clean", GoVersion:"go1.13.5"}

kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  --namespace cert-manager \
  --version v0.12.0 \
  cert-manager \
  jetstack/cert-manager
```

# 集群预置 ClusterIssuer 

- [letsencrypt-staging-cluster](./letencrypt-staging-cluster.yaml) : 用于测试 - https://letsencrypt.org/docs/staging-environment/
- [letsencrypt-cluster](./letencrypt-cluster.yaml) : 可用于从 letsencrypt 申请生产环境有效证书

# 常用用法

1. 直接请求生产证书：https://cert-manager.io/docs/usage/certificate/
2. 在 nginx ingress 中使用：https://cert-manager.io/docs/tutorials/acme/ingress/

其它详见 [usage](https://cert-manager.io/docs/usage/).
