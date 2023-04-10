
FROM node:18.13.0 AS builder

WORKDIR /first-docker

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

# COPY --from=builder /hello-world/dist/hello-world /usr/share/nginx/html

COPY --from=builder /first-docker/dist/first-docker /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'