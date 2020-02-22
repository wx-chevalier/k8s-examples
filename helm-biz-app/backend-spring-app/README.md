# 通用 Spring 应用配置 Chart

| 参数                             | 描述                  | 默认                                      | 必须 | 作用域                 |
| -------------------------------- | --------------------- | ----------------------------------------- | ---- | ---------------------- |
| `serverPort`                     | Spring 应用端口       | `80`                                      |      | `configmap/deployment` |
| `serverTimezone`                 | JVM 启动时区          | `Asia/Shanghai`                           |      | `deployment`           |
| `localFileStore.savePath`        | 本地存储文件存储路径  | `/yourbiz/files`                          |      | `deployment/configmap` |
| `localFileStore.maxFileSize`     | 本地存储文件最大大小  | `1024MB`                                  |      | `deployment/configmap` |
| `localFileStore.endpoint`        | 本地存储文件 endpoint | `https://api.yourdomain.com/file`         |      | `deployment/configmap` |
| `oss.accessKeyId`                |                       |                                           | true | `secret`               |
| `oss.accessKeySecret`            |                       |                                           | true | `secret`               |
| `oss.endpoint`                   |                       |                                           | true | `configmap`            |
| `oss.bucketName`                 |                       |                                           | true | `configmap`            |
| `oss.expiration`                 |                       | `900`                                     |      | `configmap`            |
| `oss.maxSize`                    |                       | `17179869184`                             |      | `configmap`            |
| `oss.callbackUrl`                |                       | `https://api.yourdomain.com/callback/oss` |      | `configmap`            |
| `mail.port`                      |                       | `465`                                     |      | `configmap`            |
| `mail.host`                      |                       | `smtp.exmail.qq.com`                      |      | `configmap`            |
| `mail.username`                  |                       | `notice@yourdomain.com`                   |      | `configmap`            |
| `mail.password`                  |                       |                                           | true | `secret`               |
| `sms.regionId`                   |                       | `cn-hangzhou`                             |      | `configmap`            |
| `sms.signName`                   |                       | `优联智造`                                |      | `configmap`            |
| `sms.accessKeyId`                |                       |                                           | true | `secret`               |
| `sms.accessKeySecret`            |                       |                                           | true | `secret`               |
| `jwt.secret`                     |                       |                                           | true | `secret`               |
| `wechat.appId`                   |                       |                                           | true | `configmap`            |
| `wechat.token`                   |                       |                                           | true | `secret`               |
| `wechat.appSecret`               |                       |                                           | true | `secret`               |
| `dingTalk.accessToken`           |                       |                                           |      | `secret`               |
| `msg.deviceCodeBlackListPattern` |                       |                                           |      | `configmap`            |
| `msg.deviceCodeWhiteListPattern` |                       |                                           |      | `configmap`            |
| `rabbitMqVirtualHost`            |                       | `/dev`                                    |      | `configmap`            |
| `persistence.enabled`            |                       | `false`                                   |      | `deployment/pvc`       |
| `persistence.existingClaim`      |                       |                                           |      | `deployment/pvc`       |
| `persistence.size`               |                       |                                           |      | `pvc`                  |
| `persistence.accessMode`         |                       |                                           |      | `pvc`                  |
| `persistence.storageClass`       |                       |                                           |      | `pvc`                  |
| `persistence.annotations`        |                       | `-`                                       |      | `pvc`                  |
| `service.type`                   |                       | `ClusterIP`                               |      | `service`              |
| `service.port`                   |                       | `80`                                      |      | `service/ingress`      |
| `ingress.enabled`                |                       |                                           |      | `ingress`              |
| `ingress.annotations`            |                       |                                           |      | `ingress`              |
| `ingress.hosts`                  |                       |                                           |      | `ingress`              |
| `ingress.tls`                    |                       |                                           |      | `ingress`              |

# MySQL 配置

如果 `mysql.enabled`，启动内部 MySQL，`mysql` 的配置见 [helm/charts/stable/mysql](https://github.com/helm/charts/tree/master/stable/mysql)，否则使用 `externalMySql` 配置：

| 参数                     | 描述                                        | 必须 | 作用域                      |
| ------------------------ | ------------------------------------------- | ---- | --------------------------- |
| `mysql.enabled`          | false 则使用 `externalMySql.*` 配置的数据库 |      | deployment/configmap/secret |
| `externalMySql.url`      |                                             | true | configmap                   |
| `externalMySql.username` |                                             | true | configmap                   |
| `externalMySql.password` |                                             | true | secret                      |

另外 `mysql` 添加了自定义 jdbc 参数：

| 参数                   | 默认                                                                                         | 作用域    |
| ---------------------- | -------------------------------------------------------------------------------------------- | --------- |
| `mysql.extralJdbcArgs` | `allowMultiQueries=true&useLegacyDatetimeCode=false&useUnicode=true&characterEncoding=utf-8` | configmap |

# RabbitMq 配置

**作用域：`secret`**

如果 `rabbitmq.enabled`，启动内部 Rabbitmq，`rabbitmq` 配置见 [helm/charts/stable/rabbitmq](https://github.com/helm/charts/tree/master/stable/rabbitmq)，否则使用
`rabbitmq` 配置：

| 参数                | 必须 | 作用域                        |
| ------------------- | ---- | ----------------------------- |
| `rabbitmq.enabled`  |      | `deployment/configmap/secret` |
| `rabbitmq.host`     | true | `configmap`                   |
| `rabbitmq.port`     | true | `configmap`                   |
| `rabbitmq.username` | true | `configmap`                   |
| `rabbitmq.password` | true | `secret`                      |
