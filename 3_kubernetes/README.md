# java_migration
Example Java apps to Kubernetes migration project

---

## 3. Kubernetize the app

Third step is to make the app running in Kubernetes cluster. For that we need to create some YAML files to define deployment and service/ingress to expose it. See example in this folder.

```
$ kubectl apply -f app1_deploy.yaml
deployment.apps/java-app1-deployment created
service/java-app1-service created

$ kubectl get pods
NAME                                    READY   STATUS    RESTARTS   AGE
java-app1-deployment-7dc7b5b858-gwd27   1/1     Running   0          4m

$ kubectl get svc
NAME                TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)          AGE
java-app1-service   LoadBalancer   10.43.0.173   174.138.104.65   8080:32087/TCP   6m9s

$ curl 174.138.104.65:8080
Java App 1 v0.1
```
