# Docker 安装

```
# 启动 rancher
docker run --name rancher -d --restart=unless-stopped -p 65480:80 rancher/rancher

# 创建 Ingress 将域名 https://kubernetes.yourdomain.com 指向该安装
kubectl apply -f rancher-ingress.yaml
```

| 用户名 | 密码         |
| ------ | ------------ |
| admin  | Yourpassword |

登陆之后按提示配置域名，然后添加集群 yourbiz，按指示配置即可。

# helm 安装

⚠️ Helm 安装启动不了，原因不确定，有可能是 chart 版本对 Kubernetes 1.6 支持不佳。

详情见 [Installing Rancher Using the Helm Kubernetes Package Manager](https://rancher.com/docs/rancher/v2.x/en/installation/ha/helm-rancher/)

```sh
helm version
# version.BuildInfo{Version:"v3.0.2", GitCommit:"19e47ee3283ae98139d98460de796c1be1e3975f", GitTreeState:"clean", GoVersion:"go1.13.5"}

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system

helm install rancher rancher-latest/rancher \
     --namespace cattle-system \
     --set ingress.tls.source=letsEncrypt \
     --set hostname=kubernetes.yourdomain.com \
     --set certmanager.version='0.12.0' \
     --version 2.3.4-rc7

# 注意跟踪最新版本，安装更新
# https://github.com/rancher/rancher/releases
helm upgrade rancher rancher-latest/rancher \
     --namespace cattle-system \
     --set ingress.tls.source=letsEncrypt \
     --set hostname=kubernetes.yourdomain.com \
     --set certmanager.version='0.12.0' \
     --version 2.3.4-rc8

# 测试安装时添加参数
# --set letsEncrypt.environment='dev' \
```
