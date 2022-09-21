# java_migration
Example Java apps to Kubernetes migration project

---

## 2. Dockerize apps

Second step is to package apps into docker containers. For this we have a few options. Option 1 is to to "compile" apps into JAR files and use Maven `package` plugin which can automatically build an image for us or option 2 which is to write Dockerfiles ourselves, build container images and then try to run the apps from a container.

Option 1: (not tested)
1. To create JAR files: `./mvnw -DskipTests package`
2. Example of building and shipping image to gcr: `./mvnw -DskipTests com.google.cloud.tools:jib-maven-plugin:build \
  -Dimage=gcr.io/$GOOGLE_CLOUD_PROJECT/hello-java:v1`

Option 2:
1. Create Dockerfile (see example in this folder)
2. Build image: `docker build -t java_app1 .`
3. Run app from container: `docker run -p 8080:8080 java_app1`
4. Open http://localhost:8080 to validate that it works

Extra:
In the next step (Kubernetes deployment) we'll need this docker image to be available in some container registry. For tests I used my dockerhub account and pushed the image there as follows:

1. `docker tag java_app1:latest davezworka/java_app1:0.1`
2. `docker push davezworka/java_app1:0.1`
