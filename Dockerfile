ARG APP_DIR="/app"
ARG BACKEND_URI="/api"

# Stage 1: build React app
FROM node:20-alpine as build
WORKDIR $APP_DIR
ENV REACT_APP_API_BASE_URL=$BACKEND_URI
COPY . . 
RUN npm install
RUN npm run build

# Stage 2: copy build to Nginx
FROM nginx:alpine
COPY nginx/* /etc/nginx/templates/
COPY --from=build ${APP_DIR}/build/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]