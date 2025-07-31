# Step 1: Use official Node base image
FROM node:18-alpine

# Step 2: Set working directory inside the container
WORKDIR /node-js-sample

# Step 3: Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Step 4: Copy application source code
COPY . .

# Step 5: Expose port the app runs on
EXPOSE 3000

# Step 6: Define the command to run the app
CMD ["node", "index.js"]

