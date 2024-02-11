# chronocat-linux
**该仓库仅为学习Docker打包所用，如有侵权请发送邮件至flymyd@foxmail.com联系本人，我将会在阅读邮件后24小时内删除。**

## 使用方法

### 运行镜像

```shell
docker run -d --name chronocat -p 16340:16340 -p 16530:16530 chronocat-linux:latest
```

### 获取登录链接

```shell
docker logs chronocat | grep -A1 "访问此链接以登录" | head -n 2
```

请将链接中的`127.0.0.1`全部替换为**docker宿主机的IP**，并在浏览器中访问。

### 获取Red Token

```shell
docker exec -it chronocat cat /root/.chronocat/config/chronocat.yml | grep token
```

复制`Token`节点的值即可。



