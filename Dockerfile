# Dockerfile bellow does the following: 
# - parses contents of the sample project (examples/typescript-angular)
# - triggers sourcemap generation
# - submits the data to the js-agent instance running on host specified in config located at ./examples/typescript-angular/drill4js.config.json
# note that config was prepared beforehand. You can refer to it as a sample config
FROM node:14.5.0-alpine3.12

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

# # Setup wait utility (js-agent must launch first, otherwise it is impossible to submit parsing results)
# ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
# RUN chmod +x /wait

# Replace default host & parse project
CMD sed -i 's/jsagent:9404/'${JS_AGENT_HOST}'/g' drill4js.config.json && npx drill4js-cli@${JS_AST_PARSER_VERSION} -s -c ./drill4js.config.json -b ${BUILD_VERSION}
