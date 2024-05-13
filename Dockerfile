# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY . .
#replace project name with your Project Name
ENTRYPOINT ["dotnet", "Project_Name.dll"]
EXPOSE 80
EXPOSE 443
