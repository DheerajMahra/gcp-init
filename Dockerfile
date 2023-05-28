FROM node:18.16.0-alpine3.17 as build
WORKDIR /app
COPY package*.json .
RUN yarn install --silent
COPY . .
RUN yarn build:prod

FROM nginx:1.24.0-alpine3.17
COPY --from=build app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]