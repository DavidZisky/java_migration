# java_migration
Example Java apps to Kubernetes migration project

---

## 1. Run apps locally

First step is to make sure that we can run apps locally. For testing purposes and also to be able later validate that apps works as expected once we dockerize them.

To run apps locally:

1. Execute `./mvnw -DskipTests spring-boot:run` (from withing App[x] folder)
2. Open http://localhost:8080 and you should see `Java App [x] v0.1`
