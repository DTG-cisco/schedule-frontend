# Stage 1: build React app
FROM node:20-alpine as build

ARG REACT_APP_API_BASE_URL=/api
WORKDIR /app

COPY package.json .    
RUN npm install
COPY . .                         
RUN yarn build                    

# Stage 2: copy build to Nginx
FROM nginx:alpine
COPY ./nginx/* /etc/nginx/templates/
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]