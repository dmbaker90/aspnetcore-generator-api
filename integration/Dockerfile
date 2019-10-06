# Build stage
FROM microsoft/dotnet:2-sdk 
WORKDIR /integration

# restore
COPY integration.csproj .
RUN dotnet restore

COPY . .

# now these area ready to run with dotnet test
ENTRYPOINT ["dotnet", "test"]