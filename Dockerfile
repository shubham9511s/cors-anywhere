# Stage 1: Build the application
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

#####################################################

# Stage 2: Run the application
FROM node:18-alpine

# Create and set the working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app /app

# Expose the port the app runs on
EXPOSE 9000

# Run the application
CMD ["node", "server.js"]
