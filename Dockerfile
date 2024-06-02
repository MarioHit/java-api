FROM ubuntu:latest AS build

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven

# Copier les fichiers Maven Wrapper et leur donner les permissions d'exécution
COPY mvnw /app/mvnw
COPY mvnw.cmd /app/mvnw.cmd
RUN chmod +x /app/mvnw

# Copier le reste des fichiers de l'application
COPY . /app

# Définir le répertoire de travail pour exécuter les commandes suivantes
WORKDIR /app

# Construire l'application
RUN ./mvnw clean package -DskipTests

FROM openjdk:17-jdk-slim

EXPOSE 8080

# Copier le fichier JAR généré depuis l'étape de construction
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
