# 配置

以下三个配置（作用域 `deployment`）配合使用可以用于生成服务器服务的静态资源：

- sharedVolumes: 定义各个容器（包括 initContainer）共享的卷
- initContainers: 可以定义生成静态资源的容器
- sharedVolumeMounts: 将相关卷挂载进入服务器

一个完整的示例在 [example/values.yaml](./example/values.yaml)。

# ingress with tls 示例

```yaml
ingress:
  enabled: true
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    kubernetes.io/ingress.class: "nginx"
    cert-manager.io/cluster-issuer: "letsencrypt-staging-cluster"
  hosts:
    - host: a.com
      paths:
        - /
  tls:
    - secretName: a-com-tls
      hosts:
        - a.com
```
