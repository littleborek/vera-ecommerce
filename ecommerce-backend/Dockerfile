FROM eclipse-temurin:21-jdk-alpine
VOLUME /tmp
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
# Resolve dependencies to improve caching
RUN ./mvnw dependency:go-offline
COPY src ./src
# Build the application skipping tests
RUN ./mvnw clean package -DskipTests
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","target/ecommerce-0.0.1-SNAPSHOT.jar"]
