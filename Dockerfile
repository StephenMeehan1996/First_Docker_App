
# # Use nginx to serve the application ##
# FROM nginx:alpine

# ## Remove default nginx website  
# RUN rm -rf /usr/share/nginx/html/*

# ## Copy over the artifacts in dist folder to default nginx public folder  
# COPY /dist/first-docker /usr/share/nginx/html

# ## nginx will run in the forground  
# CMD [ "nginx", "-g", "daemon off;" ]



# need to use the specific version of node that is dist is built 
FROM node:18.13.0 AS builder

WORKDIR /first-docker

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

COPY --from=builder /hello-world/first-docker /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'