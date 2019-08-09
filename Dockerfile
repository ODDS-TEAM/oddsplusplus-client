# Create the container from the alpine linux image
FROM alpine:3.7

# Copy the respective nginx configuration files
COPY nginx_config/nginx.conf /etc/nginx/nginx.conf
COPY nginx_config/default.conf /etc/nginx/conf.d/default.conf

# Set the directory we want to run the next commands for
WORKDIR /tmp/nginx/vue-single-page-app
# Copy our source code into the container
COPY . .
# Install the dependencies, can be commented out if you're running the same node version
RUN npm install

# run webpack and the vue-loader
RUN npm run build

# copy the built app to our served directory
RUN cp -r dist/* /var/www/html

# make all files belong to the nginx user
RUN chown nginx:nginx /var/www/html

# start nginx and keep the process from backgrounding and the container from quitting
CMD ["nginx", "-g", "daemon off;"]