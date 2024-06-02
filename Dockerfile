FROM ubuntu:latest AS build

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven

# Copier les fichiers Maven Wrapper
COPY mvnw /app/mvnw
COPY mvnw.cmd /app/mvnw.cmd

# Définir le répertoire de travail
WORKDIR /app

# Copier le reste des fichiers de l'application
COPY . .

# Donner les permissions d'exécution à mvnw
RUN chmod +x mvnw

# Construire l'application
RUN ./mvnw clean package -DskipTests

FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copier le fichier JAR généré depuis l'étape de construction
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
