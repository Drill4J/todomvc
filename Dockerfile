FROM node:14.5.0-alpine3.12 as build

# Create app directory
WORKDIR /usr/src/app

# Copy sample project
COPY ./examples/typescript-angular ./typescript-angular

# Navigate to a sample project folder
WORKDIR /usr/src/app/typescript-angular

# Install dependencies
RUN npm install --silent

# Compile in order to generate sourcemaps (those are required for source-parsing utility at a later stage)
RUN npm run compile

  # replace default JS-agenthost in drill4j config
CMD sed -i 's/jsagent:9404/'${JS_AGENT_HOST}'/g' drill4js.config.json \
  # parse project
  && npx drill4js-cli@${JS_AST_PARSER_VERSION} -s -c ./drill4js.config.json -b ${BUILD_VERSION}

# host sampleapp
FROM nginx:latest
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www
COPY --from=build /usr/src/app/typescript-angular/ /var/www