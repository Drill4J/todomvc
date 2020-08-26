# Drill4J sample project
This is a fork of [TodoMVC]() repo created as an example to help anyone to gear up their JavaScript (TypeScript, CofeeScript is fine too) project with Drill4J.

## I just want a demo
This is fairly simple (**Tip:** don't be intimidated by a lengthy guide, it's just very detailed): 
1. Launch Drill4J services
2. Install Browser extension
3. Collect coverage and see it in Drill4J Admin UI

### Step 1 - Spin up Drill4J services
At first, you need to launch Drill4J backend services. For the sake of demo, container that will parse sample project on launch is added to `docker-compose.yml`[/docker-compose.yml] as well.
1. Clone this repo
2. Run `docker-compose up -d`
3. Once it's done, open [Drill4J Admin UI](http://localhost:9091) (at http://localhost:9091)
4. If you see an empty page, wait a minute (Drill4J is scanning the sample project)
5. When agents list is up, press *Register* button
6. Click through **Step 1** and **Step2**, but make sure to **enable Test2Code plugin on Step3**
7. Press *Finish Registration* button

[//]: # (list terminator)

You now should be at [**todomvc-typescript-angular** agent's dashboard](http://localhost:9091/full-page/todomvc-typescript-angular/0.0.1/dashboard). Click on *View more* button to see [Test2Code plugin](http://localhost:9091/full-page/todomvc-typescript-angular/0.0.1/test2code/dashboard) page.
Project sourcecode tree must be present at the bottom of the page.

### Step 2 - Install Browser Extension 
To see Drill4J in action you need to install our [Browser Extension](https://github.com/Drill4J/browser-extension/releases):
1. Download `.zip` with the latest release
2. Unpack it
3. Add it to Google Chrome via [chrome://extensions/](chrome://extensions/) (enable Developer mode, click "Install upacked extension", select "build" folder from .zip file)
4. Open extension settings and add new entry
```
Host = todomvc.com
Agent id = todomvc-typescript-angular
Agent URL = localhost:9404
Agent Type = JS
```

### Step 3 - Collect some coverage
You are all set!
1. Open [TodoMVC typescript-angular demo](http://todomvc.com/examples/typescript-angular/#/) page
2. Launch our Drill4J browser extension. Wait for it to detect a domain and create a Widget
3. In widget window press on tab with a checkmark
4. Start testing!

[//]: # (list terminator)

Coverage for all methods that you've triggered must be visible at agent's page in Drill4J Admin

## I want to setup Drill4J for my own JavaScript project
### Launch Drill4J services
1. Copy both [docker-compose.yml](/docker-compose.yml) and [.env](/.env) to any folder.
2. Delete `sampleproject` service from `docker-compose.yml`.
3. Launch Drill4J services with `docker-compose up -d`
4. [Drill4J Admin UI](http://localhost:9091) should be available

### Parse your project
1. Add `drill4js.config.json` to your project root. Use [/examples/typescript-angular/drill4js.config.json](/examples/typescript-angular/drill4js.config.json) as a reference
2. **Tip:** replace all entries of "todomvc-typescript-angular" with your project name. Letters, digits, slashes and spaces are allowed. Just remember to **set correct agent name** when configuring browser extension
3. Run `npx drill4js-cli -s -c drill4js.config.json -b 0.0.1` in your project root. **Note:** that last `-b` is your Build Version number. Make sure to increment that each time you run `drill4js-cli` utility.
You should be able to see your projects sourcecode tree in [Drill4J Admin UI](http://localhost:9091) (http://localhost:9091) at Test2Code plugin page

### What's next?
1. Use Drill4J browser extension to collect manual tests coverage
2. Integrate `npx drill4js-cli -s -c drill4js.config.json -b 0.0.1` into build pipeline to get the most out of Drill:
- detect **risks:** (new and modified methods)
- **see gaps** in your **coverage**
- get suggestions on **test to run**
- **analyze overlap** in your manual and autotest sessions

## Troubleshooting
Despite everyone's best efforts problems still might occur. Feel free to ask for help in our [Telegram chat](https://t.me/drill4j)!