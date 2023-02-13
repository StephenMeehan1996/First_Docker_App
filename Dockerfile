# Use nginx to serve the application ##
FROM nginx:alpine

## Remove default nginx website  
RUN rm -rf /usr/share/nginx/html/*

## Copy over the artifacts in dist folder to default nginx public folder  
COPY /dist/project-name /usr/share/nginx/html

## nginx will run in the forground  
CMD [ "nginx", "-g", "daemon off;" ]
