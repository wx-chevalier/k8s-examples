```sh
## 1. 创建 Docker registry 所需 PV & PVC
kubectl apply -f registry-pv.yaml

## 2. 创建 Docker 验证信息
docker run --entrypoint htpasswd registry:2 -Bbn yourbiz 632437FC-716B-4C7C-9829-1D74F71431A1 > ./htpasswd

## 3. 启动 Docker Registry
helm install --namespace yourbiz-infra docker-registry -f values.yaml stable/docker-registry

## 4. 可以使用 values.yaml 更新 Docker registry
helm upgrade --namespace yourbiz-infra -f values.yaml docker-registry stable/docker-registry
```

创建 Image Pulling Secret 供后续使用（[Pull an Image from a Private Registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/）：)

```sh
# 给我们需要用到的 namespace 添加 Image Pulling Secret
for n in "yourbiz-infra" "yourbiz-dev" "yourbiz-prod";
do
    kubectl create secret docker-registry regcred \
        --docker-server=registry.yourdomain.com \
        --docker-username=yourbiz \
        --docker-password=632437FC-716B-4C7C-9829-1D74F71431A1 \
        --docker-email=registry@yourdomain.com \
        --namespace yourbiz-dev
done
```
