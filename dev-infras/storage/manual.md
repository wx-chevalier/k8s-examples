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
