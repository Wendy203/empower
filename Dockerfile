# Dockerfile para Flutter Web
FROM debian:latest AS build-env

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    xz-utils \
    zip \
    libgconf-2-4 \
    gdb \
    libstdc++6 \
    libglu1-mesa \
    fonts-droid-fallback \
    lib32stdc++6 \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Clonar el repositorio de Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Configurar Flutter en el PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Ejecutar flutter doctor
RUN flutter doctor -v

# Habilitar Flutter Web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY pubspec.yaml pubspec.lock ./

# Descargar dependencias
RUN flutter pub get

# Copiar el resto del código fuente
COPY . .

# Construir la aplicación web
RUN flutter build web --release

# Etapa de producción con Nginx
FROM nginx:alpine

# Copiar los archivos construidos desde la etapa anterior
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Copiar configuración de nginx personalizada
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
