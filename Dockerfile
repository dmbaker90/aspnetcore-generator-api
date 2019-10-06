# Build stage
FROM microsoft/aspnetcore-build:2.0.0 AS build-env

WORKDIR /generator

# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj
COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# copy src
COPY . .
# test  If tests don't pass we don't get image (it doesn't matter if we have test in build file because it all gets throw away in second stage for runtime optimization)
RUN dotnet test tests/tests.csproj
# publish
RUN dotnet publish api/api.csproj -o /publish

# runtime stage
FROM microsoft/aspnetcore:2.0.0
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]