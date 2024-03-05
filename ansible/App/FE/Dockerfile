FROM node:18 AS build
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


FROM nginx:1.22 AS deploy
WORKDIR /app
COPY --from=build dist /app/
COPY nginx.conf /etc/nginx/nginx.conf
CMD [ "nginx", "-g", "daemon off;" ]
