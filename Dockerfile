# Stage 1: Build the Node.js GUI
FROM node:20.11-slim AS build-stage
WORKDIR /usr/src/app
COPY ./gui/package*.json ./
COPY ./gui ./


# Stage 2: Final image for the farm-proxy-gui
FROM node:20.11-slim
WORKDIR /usr/src/app
COPY --from=build-stage /usr/src/app/build ./build

# Убедитесь, что эти каталоги существуют, либо удалите строки, если они не нужны

COPY ./monitoring ./monitoring
COPY ./.env ./.env

ENV NODE_ENV=production

CMD ["node", "--env-file=.env", "build/server/server.cjs"]

# Expose the necessary ports
EXPOSE 7777
EXPOSE 3333
EXPOSE 3000
EXPOSE 9090
EXPOSE 8080
