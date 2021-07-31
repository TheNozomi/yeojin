# uwu
FROM node:16.5.0-alpine3.12

RUN mkdir /home/node/app/ && chown -R node:node /home/node/app
WORKDIR /home/node/app

# Copy package.json and package-lock.json
COPY --chown=node:node ./package*.json ./

WORKDIR /home/node/app
USER node

# Install npm packages
RUN npm install --loglevel info

# Copy app source files
COPY --chown=node:node . ./

# Build
RUN npm run build

# Environment variables
ENV PORT=3000

# Expose HTTP port
EXPOSE $PORT

# Run server
CMD ["npm", "start"]
