# Stage 1: Build the project
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o /app/out

# Stage 2: Run the project
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

# Expose ports for HTTP and HTTPS
EXPOSE 80
EXPOSE 443

# Set environment variables for Kestrel
ENV ASPNETCORE_URLS="http://+:80;https://+:443"
ENV ASPNETCORE_Kestrel__Certificates__Default__Path=/app/cert.pfx
ENV ASPNETCORE_Kestrel__Certificates__Default__Password=

# Copy the SSL certificate
COPY cert.pfx /app/cert.pfx

# Copy the build output from the build stage
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "Web-API-Template.dll"]
