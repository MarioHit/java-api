# Étape de build
FROM ubuntu:22.04 AS build

# Installer OpenJDK et Maven, puis nettoyer les caches APT
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven && \
    rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement le pom.xml pour que les dépendances Maven soient résolues plus rapidement
COPY pom.xml /app/

# Résoudre les dépendances Maven
RUN mvn dependency:resolve

# Copier le reste du code source et construire l'application
COPY src /app/src
RUN mvn clean package -DskipTests

# Étape de production
FROM openjdk:17-jdk-slim

# Variables d'environnement pour une meilleure flexibilité
ENV APP_HOME=/app
ENV JAR_FILE=demo-0.0.1-SNAPSHOT.jar

# Définir le répertoire de travail
WORKDIR $APP_HOME

# Copier le fichier JAR généré depuis l'étape de build
COPY --from=build /app/target/$JAR_FILE app.jar

# Exposer le port
EXPOSE 8080

# Entrée de l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
