FROM node:22-alpine AS build
WORKDIR /usr/src/app
COPY prod-frontend/package.json  prod-frontend/package-lock.json ./
RUN npm install
COPY prod-frontend/ .
RUN npm run build

#STAGE 2
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist /usr/share/nginx/html