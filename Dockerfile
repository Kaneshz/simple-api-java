# Estágio 1: Compilar a aplicação com Maven
# AJUSTE: Usando uma imagem com Maven e Java 21, que é a versão do seu projeto.
FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app

# Otimização: Copia o pom.xml primeiro e baixa as dependências.
# Isso cria uma camada de cache. O Docker só vai baixar tudo de novo se o pom.xml mudar.
COPY pom.xml .
RUN mvn dependency:go-offline

# Agora copia o código-fonte
COPY src ./src

# Compila e empacota a aplicação, pulando os testes
RUN mvn package -DskipTests

# Estágio 2: Criar a imagem final para rodar a aplicação
# AJUSTE: Usando uma imagem leve com o Java 21 para rodar a aplicação compilada.
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copia o artefato .jar gerado no estágio anterior para a imagem final.
COPY --from=builder /app/target/*.jar app.jar

# Expõe a porta padrão do Spring Boot
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
