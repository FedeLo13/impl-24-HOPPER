# Etapa de construcción del frontend
FROM node:20 as build

WORKDIR /app

COPY app/src/package.json ./

# Instala las dependencias del proyecto
RUN npm install --loglevel=error

COPY app/public public/
COPY app/src/App.js src/
COPY app/src/index.js src/

RUN npm run build

from node:20 as production

WORKDIR /app

COPY app/src/package.json ./

RUN npm install --only=production --loglevel=error

# Instala JDK
RUN apt-get update && \
    apt-get install -y default-jdk

# Copia el backend.js
COPY app/src/backend.js ./

COPY src/main/java main/java

# Copia los archivos estáticos generados del frontend a la carpeta pública
COPY --from=build /app/build/ public/

# Expone el puerto que usa el servidor Express
EXPOSE 3200

# Comando para arrancar el servidor de Express
CMD ["node", "backend.js"]