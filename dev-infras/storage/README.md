# 存储

## 阿里云磁盘管理

注意，买的云盘统一都挂载到了服务器上的 `/opt/disks/` 目录下对应磁盘名中，如 `/opt/disks/vdb/`。

## Kubernetes 存储管理

- [手工管理存储](./manual.md)
- [Rook](./rook.md) : https://rook.io/docs/rook/master/ceph-block.html

## 数据备份

Kubernetes native way:

- https://github.com/stashed/stash
- https://github.com/vmware-tanzu/velero

Ceph native tools:

- http://backy2.com/

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

# 手工管理不同节点上的存储

## 给节点打存储相关标签

方便创建指定服务器上的 PersistentVolume，为各节点打上标签

```sh
kubectl label nodes yourbiz-master 'yourdomain.com/bare-metal-storage-name=yourbiz-master'
kubectl label nodes yourbiz-slave000 'yourdomain.com/bare-metal-storage-name=yourbiz-slave000'
kubectl label nodes yourbiz-slave001 'yourdomain.com/bare-metal-storage-name=yourbiz-slave001'
```

## 创建指定节点上的 PV 和使用该 PV 的 PVC

关于 PV 概念，详见 [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

创建 PV，下面的配置文件创建了一个 PV，大小 50G，通过 selector 和 volumeMode 指明该存储位于 yourbiz-master 服务器上文件系统
的 `/opt/disks/vdb/gitlab-pvs/pv-gitlab-data/` 目录。

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: gitlab-data
  namespace: yourbiz-infra
spec:
  storageClassName: ""
  capacity:
    storage: 50Gi
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  hostPath:
    path: /opt/disks/vdb/gitlab-pvs/pv-gitlab-data/
    type: ""
  persistentVolumeReclaimPolicy: Retain
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: yourdomain.com/bare-metal-storage-name
              operator: In
              values:
                - yourbiz-master
```

可以创建一个 PVC 直接使用该 PV：

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: gitlab-data
  namespace: yourbiz-infra
spec:
  storageClassName: ""
  volumeName: gitlab-data
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
```

这样，在 Deployment 中需要使用到 PVC 的地方可以直接引用该 PVC。
