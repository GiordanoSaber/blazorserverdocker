# Define la imagen de base a utilizar
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo .csproj y restaura las dependencias
COPY *.csproj ./
RUN dotnet restore

# Copia todo el resto del código fuente y compila la aplicación
COPY . ./
RUN dotnet publish -c Release -o /app/out

# Crea una nueva imagen para la aplicación y establece la imagen de base
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .

# Establece el comando de inicio de la aplicación
ENTRYPOINT ["dotnet", "dotnet.dll"]
