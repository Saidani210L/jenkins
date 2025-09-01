# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "JenkinsApp.dll"]


# // --- Jenkins image ---
# FROM jenkins/jenkins:2.516.2-jdk21
# USER root
# RUN apt-get update && apt-get install -y lsb-release ca-certificates curl && \
#     install -m 0755 -d /etc/apt/keyrings && \
#     curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
#     chmod a+r /etc/apt/keyrings/docker.asc && \
#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
#     https://download.docker.com/linux/debian $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
#     | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
#     apt-get update && apt-get install -y docker-ce-cli && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*
# USER jenkins
# RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"