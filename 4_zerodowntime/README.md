# java_migration
Example Java apps to Kubernetes migration project

---

## 4. Zero-downtime deployments

Fourth and last step is to make our application upgradeable with zero-downtime. If we just containerized it and made basic deployment like in the previous step, deploying a new version will introduce some downtime as shown below:

```
$ ./probe.sh
Probing app at 08:54:55 PM:
Java App 1 v0.2
Probing app at 08:54:57 PM:
Java App 1 v0.2
Probing app at 08:54:59 PM:
curl: (56) Recv failure: Connection reset by peer
(...)
Probing app at 08:55:33 PM:
curl: (56) Recv failure: Connection reset by peer

Probing app at 08:55:35 PM:
Java App 1 v0.1
Probing app at 08:55:37 PM:
Java App 1 v0.1
Probing app at 08:55:39 PM:
Java App 1 v0.1^C

```

Why is that? By default Kubernetes offers rolling upgrades, which means it deploys a new version of the application and only once it's up and running then it destroys the old, so there shouldn't be any downtime. But the key here is the "up and running" piece. We didn't instruct Kubernetes on how to check if our application is actually running so all it does is waiting for the docker container being in "running" state. But it will take a few seconds for our application to initialize and be ready to accept connection. We know that Java applications take quite long time to initiate so we can add startupProbe to our deployment definition:

```
startupProbe:
  httpGet:
    path: /
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 3
```

This piece of code will tell Kuberentes to wait 30 seconds after contianer is running and then try to make HTTP call to our application. And only if the application responds properly (HTTP 200) Kubernetes will switch the traffic to the new pod with (near) zero-downtime:

```
$ ./probe.sh
Probing app at 09:09:11 PM:
Java App 1 v0.1
(...)
Probing app at 09:09:44 PM:
Java App 1 v0.1
Probing app at 09:09:46 PM:
Java App 1 v0.2
Probing app at 09:09:48 PM:
Java App 1 v0.2
Probing app at 09:09:51 PM:
Java App 1 v0.2^C
```
