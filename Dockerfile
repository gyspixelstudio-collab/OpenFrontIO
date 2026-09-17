# Use a highly compatible Node 18 runtime
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Disable husky hooks that block cloud environments
ENV HUSKY=0

# Copy configuration files
COPY package*.json ./
COPY tsconfig.json ./
COPY vite.config.ts ./
COPY eslint.config.js ./
COPY index.html ./
COPY client-api.json ./

# Install dependencies using standard installation
RUN npm run inst

# Copy remaining code files
COPY scripts ./scripts
COPY src ./src
COPY zbin ./zbin
COPY resources ./resources
COPY proprietary ./proprietary

# Compile the production asset hashes and build the client
RUN npm run build-prod

# Expose the internal game engine port
EXPOSE 3000

# Start the game server directly
CMD ["npm", "run", "start"]
