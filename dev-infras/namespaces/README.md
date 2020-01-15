# 配置远程访问

配置集群地址（cluster.crt 在 [yourbiz-cluster.crt](../cluster/yourbiz-cluster.crt)）：

```sh
kubectl config set-cluster yourbiz --server=https://youadress:6443 --certificate-authority=/path/to/cluster.crt
```

## yourbiz-dev

token:

```text
yourtoken
```

配置访问权限：

```sh
kubectl config set-credentials yourbiz-dev-admin --token=$TOKEN
kubectl config set-context yourbiz-dev --cluster=yourbiz --user=yourbiz-dev-admin --namespace yourbiz-dev

# 测试
kubectl config use-context yourbiz-dev
kubectl get pods
```

## yourbiz-prod

token:

```text
yourtoken
```

配置访问权限：

```sh
kubectl config set-credentials yourbiz-prod-admin --token=$TOKEN
kubectl config set-context yourbiz-prod --cluster=yourbiz --user=yourbiz-prod-admin --namespace yourbiz-prod

# 测试
kubectl config use-context yourbiz-prod
kubectl get pods
```
