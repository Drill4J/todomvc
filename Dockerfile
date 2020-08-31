# FROM node:14.5.0-alpine3.12 as build
FROM nginx:latest

# Copy nginx config
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copy sample project
WORKDIR /var/www
COPY ./examples/typescript-angular ./

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh \
  && bash nodesource_setup.sh \
  && apt-get install nodejs -y \
  && node -v \
# Install dependencies
  && npm install --silent \
# Compile in order to generate sourcemaps
  && npm run compile

# Replace default JS-agenthost in drill4j config
CMD sed -i 's/jsagent:9404/'${JS_AGENT_HOST}'/g' drill4js.config.json \
# Parse project
  && npx drill4js-cli@${JS_AST_PARSER_VERSION} -s -c ./drill4js.config.json -b ${BUILD_VERSION} \
  && nginx -g "daemon off;"