FROM ubuntu:latest AS build

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de l'application
COPY . .

# Construire l'application
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copier le fichier JAR généré depuis l'étape de construction
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
