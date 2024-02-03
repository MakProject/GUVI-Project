#base image for build stage
FROM node:16-alpine as build

#defining work directory
WORKDIR /app

#copying package.json file to app directory and installing packages to build
COPY package.json .
RUN npm install

#copying rest of the application files to the working directory
copy . .

#building the application
RUN npm run build

#base image for deploying the app
FROM nginx:alpine

#copying nginx.conf configuration file which outputs nginx metrics to default nginx config location
COPY nginx.conf /etc/nginx/conf.d/default.conf

#defining work directory for nginx
WORKDIR /usr/share/nginx/html/

#copying from build stage to nginx
COPY --from=build /app/build/ .

#exposing port 80 for the application output:
EXPOSE 80

#executing application to run in foreground
CMD ["nginx", "-g", "daemon off;"]
