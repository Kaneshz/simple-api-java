Projeto - Cidades ESGInteligentes
Este projeto consiste em uma API RESTful desenvolvida em Java com Spring Boot para gerenciar dados relacionados a cidades e seus indicadores ESG. A aplicação é totalmente containerizada com Docker e possui um pipeline de CI/CD automatizado com GitHub Actions.

Como executar localmente com Docker
Para executar o projeto em seu ambiente local, você precisa ter o Docker e o Docker Compose instalados.

Clone o repositório:



    git clone https://github.com/Kaneshz/simple-api-java.git

Navegue até a pasta do projeto:

    cd simple-api-java

Suba os containers:

O comando a seguir irá construir a imagem da API (se ainda não existir) e iniciar os containers da aplicação e do banco de dados em segundo plano.

    docker-compose up --build -d

Acesse a aplicação:

A API estará disponível em `http://localhost:8080`. Você pode usar ferramentas como Postman, Insomnia ou o seu navegador para interagir com os endpoints.
Para parar a execução:

    docker-compose down


Pipeline CI/CD

O pipeline de Integração Contínua e Deploy Contínuo (CI/CD) foi implementado utilizando GitHub Actions.

Ferramenta: GitHub Actions

Arquivo de Workflow: .github/workflows/ci-cd.yml

O pipeline é acionado automaticamente a cada push na branch main e é dividido nas seguintes etapas (jobs):

Build, Teste e Push da Imagem (build-and-test):
*   Realiza o checkout do código-fonte.
*   Configura o ambiente com Java 21.
*   Executa os testes automatizados do projeto com o comando `mvn test`.
*   Se os testes passarem, faz o login no **GitHub Container Registry (GHCR)**.
*   Constrói a imagem Docker da aplicação.
*   Envia a imagem gerada para o GHCR, tagueada como `latest`.
Deploy em Staging (deploy-staging):
*   Esta etapa é executada somente após o sucesso da etapa anterior.
*   Ela simula o deploy da nova imagem Docker em um ambiente de homologação (staging), onde a aplicação poderia ser validada por QAs ou stakeholders.
Deploy em Produção (deploy-production):
*   Esta etapa depende do sucesso do deploy em Staging.
*   **Requer aprovação manual:** Para garantir a segurança, o deploy em produção só é executado após um membro do time aprovar a execução diretamente na interface do GitHub Actions.
*   Após a aprovação, simula o deploy da aplicação no ambiente final de produção.
Containerização
A containerização foi feita utilizando Docker para garantir que o ambiente de desenvolvimento seja idêntico ao de produção, evitando problemas de compatibilidade.

Dockerfile

Utilizamos um Dockerfile com a estratégia de multi-stage build. Isso nos permite criar uma imagem Docker final muito menor e mais segura, pois ela contém apenas o necessário para executar a aplicação, sem incluir as dependências de compilação do Maven ou o JDK completo.

dockerfile


# ESTÁGIO 1: Build
# Usamos uma imagem com Maven e JDK para compilar o projeto
FROM maven:3.9.6-eclipse-temurin-21 AS builder

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de configuração do Maven
COPY pom.xml .

# Copia o código-fonte da aplicação
COPY src ./src

# Executa o build do projeto, gerando o arquivo .jar
RUN mvn clean package -DskipTests

# ESTÁGIO 2: Run
# Usamos uma imagem JRE (Java Runtime Environment) mínima para rodar a aplicação
FROM eclipse-temurin:21-jre-jammy

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo .jar gerado no estágio anterior para a imagem final
COPY --from=builder /app/target/*.jar app.jar

# Expõe a porta que a aplicação usa
EXPOSE 8080

# Comando para iniciar a aplicação quando o container for executado
ENTRYPOINT ["java", "-jar", "app.jar"]
Prints do funcionamento
[SUA TAREFA: Insira aqui os prints de tela]

1. Aplicação rodando localmente com Docker Compose:

(Print do terminal mostrando os logs de docker-compose up com a aplicação iniciada)

2. Exemplo de requisição na API (via Postman/Insomnia):

(Print de uma requisição GET ou POST para um endpoint da sua API, mostrando a resposta com status 200 OK)

3. Pipeline do GitHub Actions em execução:

(Print da aba "Actions" do seu repositório no GitHub, mostrando as etapas do pipeline com os checks verdes)

4. Aprovação manual para o deploy de produção:

(Print da etapa de deploy de produção aguardando por aprovação)

Tecnologias utilizadas
Backend: Java 21, Spring Boot 3
Banco de Dados: MySQL 8
Build: Apache Maven
Containerização: Docker, Docker Compose
CI/CD: GitHub Actions
Registro de Imagem: GitHub Container Registry (GHCR)