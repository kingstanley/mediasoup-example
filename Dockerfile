# Base image
FROM ubuntu
RUN apt-get update && apt-get install -y build-essential pip net-tools iputils-ping iproute2 curl \
    && curl -fsSL https://db.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs npm \
    && npm install -g @nestjs/cli


EXPOSE 3000
EXPOSE 11000-12500
EXPOSE 12501-13000


# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

# Creates a "dist" folder with the production build
RUN npm run build

# Start the server using the production build
CMD [ "node", "app.js" ]
