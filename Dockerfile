# uwu
FROM node:16.5.0-alpine3.12 AS build

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
RUN npm run build --standalone


# Second build stage, starting with an empty image
FROM node:16.5.0-alpine3.12

# Setting environment variables
ENV PORT=3000
ENV NUXT_VERSION=2.15.7

RUN mkdir /home/node/app/ && chown -R node:node /home/node/app
WORKDIR /home/node/app
USER node

# Adding nuxt-start, wrapper to start nuxt apps in production mode
RUN npm install "nuxt-start@${NUXT_VERSION}"

# Copying files from build stage
COPY --from=build /home/node/app/.nuxt ./.nuxt
COPY --from=build /home/node/app/nuxt.config.js ./
COPY --from=build /home/node/app/static ./

# Expose HTTP port
EXPOSE $PORT

# Run server
ENTRYPOINT ["npx", "nuxt-start"]
