# Use and existing docker image as a base and name build phase so can be used later.
FROM node:alpine as builder

# Create working directory inside container
WORKDIR '/app'

# Copy node package file to container working directory for npm install command
COPY package.json .
RUN npm install

# Copy entire node files into container 
COPY . . 

# Run command to start node server
RUN npm run build
# /app/build is directory at end with production file to serve up by nginx

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html