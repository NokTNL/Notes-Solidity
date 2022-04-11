- To let Remix have access to your local file system, need to install remixd **globally** so that the command line has the "remixd" command:

> sudo npm install -g @remix-project/remixd

- To let browser connect to your computer, you need to run remixd in the console background:
  > remixd -s <absolute-path-to-the-shared-folder> --remix-ide https://remix.ethereum.org
- For this folder it will be:

  > remixd -s ~/Solidity --remix-ide https://remix.ethereum.org

- Then go to Remix web-based IDE and connect to your computer
