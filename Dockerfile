# Stage 1: Build the Node.js GUI
FROM node:20.11-slim AS build-stage
WORKDIR /usr/src/app


# Копируем исходный код GUI
COPY ./gui ./



# Stage 2: Final image for the farm-proxy-gui
FROM node:20.11-slim
WORKDIR /usr/src/app

# Копируем собранный GUI из build-stage
COPY --from=build-stage /usr/src/app/build ./build

# Копируем конфигурационные файлы и шаблоны
COPY ./config/templates ./config/templates

COPY ./monitoring ./monitoring
COPY ./.env ./.env

# Устанавливаем переменную окружения
ENV NODE_ENV=production

# Запускаем сервер
CMD ["node", "--env-file=.env", "build/server/server.cjs"]

# Открываем необходимые порты
EXPOSE 7777
EXPOSE 3333
EXPOSE 3000
EXPOSE 9090
EXPOSE 8080
