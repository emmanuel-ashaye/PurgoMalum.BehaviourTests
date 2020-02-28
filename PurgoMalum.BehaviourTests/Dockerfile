FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["PurgoMalum.BehaviourTests/PurgoMalum.BehaviourTests.csproj", "PurgoMalum.BehaviourTests/"]
COPY ["PurgoMalum.ServiceClient/PurgoMalum.ServiceClient.csproj", "PurgoMalum.ServiceClient/"]
RUN dotnet restore "PurgoMalum.BehaviourTests/PurgoMalum.BehaviourTests.csproj"
COPY . .
WORKDIR "/src/PurgoMalum.BehaviourTests"
RUN dotnet build "PurgoMalum.BehaviourTests.csproj"

ENTRYPOINT ["tail", "-f", "/dev/null"]