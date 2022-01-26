# 通用后端应用配置 Chart

## 参数

| 参数                         | 描述                  | 默认                              | 必须 | 作用域                 |
| ---------------------------- | --------------------- | --------------------------------- | ---- | ---------------------- |
| `serverPort`                 | Spring 应用端口       | `80`                              |      | `configmap/deployment` |
| `serverTimezone`             | JVM 启动时区          | `Asia/Shanghai`                   |      | `deployment`           |
| `localFileStore.savePath`    | 本地存储文件存储路径  | `/yourbiz/files`                  |      | `deployment/configmap` |
| `localFileStore.maxFileSize` | 本地存储文件最大大小  | `1024MB`                          |      | `deployment/configmap` |
| `localFileStore.endpoint`    | 本地存储文件 endpoint | `https://api.yourdomain.com/file` |      | `deployment/configmap` |
| `persistence.enabled`        |                       | `false`                           |      | `deployment/pvc`       |
| `persistence.existingClaim`  |                       |                                   |      | `deployment/pvc`       |
| `persistence.size`           |                       |                                   |      | `pvc`                  |
| `persistence.accessMode`     |                       |                                   |      | `pvc`                  |
| `persistence.storageClass`   |                       |                                   |      | `pvc`                  |
| `persistence.annotations`    |                       | `-`                               |      | `pvc`                  |
| `service.type`               |                       | `ClusterIP`                       |      | `service`              |
| `service.port`               |                       | `80`                              |      | `service/ingress`      |
| `ingress.enabled`            |                       |                                   |      | `ingress`              |
| `ingress.annotations`        |                       |                                   |      | `ingress`              |
| `ingress.hosts`              |                       |                                   |      | `ingress`              |
| `ingress.tls`                |                       |                                   |      | `ingress`              |
