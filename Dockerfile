FROM node:alpine
USER 1000
RUN mkdir /home/node/app
WORKDIR /home/node/app
COPY --chown=1000:1000 package.json .
RUN npm install
COPY --chown=1000:1000 . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=0 /home/node/app/build /usr/share/nginx/html
