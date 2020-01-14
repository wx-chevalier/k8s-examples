# Rook

- https://rook.github.io/docs/rook/v1.2/ceph-block.html

## 安装

```sh
helm install --namespace rook-ceph rook-ceph rook-release/rook-ceph

kubectl apply -f rook-cluster.yaml

## 启动 ceph 工具箱连接到 rook 集群
# https://rook.io/docs/rook/master/ceph-toolbox.html
kubectl create -f rook-ceph-tools.yaml
kubectl -n rook-ceph get pod -l "app=rook-ceph-tools"
kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash

## 一些测试命令
# ceph status
# ceph osd status
# ceph df
# rados df
```

## 使用

```sh
## 创建 storage class
kubectl create -f rook-storageclass.yaml

## 创建一个测试 PVC
kubectl apply -f rook-example-pvc.yaml
kubectl get pvc
kubectl delete -f rook-example-pvc.yaml
```
