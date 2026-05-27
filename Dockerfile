# Build stage
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM tomcat:10.1-jdk21
# Remove default webapps to ensure our app is the root
RUN rm -rf /usr/local/tomcat/webapps/ROOT
# Copy our compiled WAR file and name it ROOT.war so it serves at the root path (/)
COPY --from=build /app/target/fashionstore.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
