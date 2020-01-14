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
