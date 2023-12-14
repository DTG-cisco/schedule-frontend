# Stage 1: build React app
FROM node:18-alpine as build
WORKDIR /app

COPY package.json .    
RUN npm install
COPY . .             
ENV REACT_APP_API_BASE_URL="/api"
RUN yarn build                    

# Stage 2: copy build to Nginx
FROM nginx:alpine

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]