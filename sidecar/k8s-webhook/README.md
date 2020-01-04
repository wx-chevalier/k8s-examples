# k8s-webhook

- 针对 admission-webhook-example=enabled 标签的命名空间生效

- 自动打标签(pod、deplpoyment、service、ingress 自动打上 app.kubernetes.io/name=not_available 的标签)

- sidecar 自动注入(pod 自动带上 nginx sidecar container)

# Development

```sh
# 利用脚本(istio团队提供的)生成CertificateSigningRequest，再生成secret(给后面的webhook-api使用)
$ ./deployment/webhook-create-signed-cert.sh

# 利用脚本生成mutatingwebhook和validatingwebhook yaml，变量CA_BUNDLE自动从kubeconfig中获取
$ cat ./deployment/validatingwebhook.yaml | ./deployment/webhook-patch-ca-bundle.sh > ./deployment/validatingwebhook-ca-bundle.yaml
$ cat ./deployment/mutatingwebhook.yaml | ./deployment/webhook-patch-ca-bundle.sh > ./deployment/mutatingwebhook-ca-bundle.yaml

# 编译镜像
$ docker build --rm -t test/admission-webhook-example:v1 -f docker/Dockerfile .

# 部署 webhook-api
$ kubectl apply -f ./deployment/mutatingwebhook-ca-bundle.yaml
$ kubectl apply -f ./deployment/validatingwebhook-ca-bundle.yaml
$ kubectl apply -f configmap.yaml
$ kubectl apply -f deployment.yaml
$ kubectl apply -f service.yaml
$ kubectl apply -f nginxconfigmap.yaml   # 这里sidecar是nginx, sidecar依赖的configmap

# 给default命名空间打label，只对admission-webhook-example标签的命名空间生效
$ kubectl label namespace default admission-webhook-example=enabled

# 部署一个busybox，sidecar是nginx
$ kubectl apply -f ./deployment/sleep.yaml
# service自动打上app.kubernetes.io/name标签
$ kubectl get svc sleep --show-labels
NAME      TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE       LABELS
sleep     ClusterIP   10.68.4.5    <none>        80/TCP    4m        app.kubernetes.io/name=not_available
# ingress自动打上app.kubernetes.io/name标签
$ kubectl get ingresses.extensions sleep --show-labels
NAME      HOSTS          ADDRESS   PORTS     AGE       LABELS
sleep     xx.sleep.com             80        4m        app.kubernetes.io/name=not_available
```
