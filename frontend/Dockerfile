FROM node:10 as builder

ARG REACT_APP_BACKEND_WS
ARG REACT_APP_BACKEND_URL

WORKDIR /app
COPY . .

RUN npm install && npm run build

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
