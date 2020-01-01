# k8s-webhook

- 针对 admission-webhook-example=enabled 标签的命名空间生效

- 自动打标签(pod、deplpoyment、service、ingress 自动打上 app.kubernetes.io/name=not_available 的标签)

- sidecar 自动注入(pod 自动带上 nginx sidecar container)

# Development

```sh
# 利用脚本(istio团队提供的)生成CertificateSigningRequest，再生成secret(给后面的webhook-api使用)
$ ./deployment/webhook-create-signed-cert.sh
```
