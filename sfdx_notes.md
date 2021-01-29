# sfdx
*– Notes on https://www.udemy.com/course/salesforcedx*

## installation process (x64 linux)

```sh
# create sfdx directory in your home directory
cd sfdx

# get installer
wget https://developer.salesforce.com/media/salesforce-cli/sfdx-cli/channels/stable/sfdx-cli-linux-x64.tar.xz

# unpack file into sfdx directory
tar xJf sfdx-cli-linux-x64.tar.xz -C sfdx --strip-components 1

# run installer
./sfdx/install
```
The installer will istall the Salesforce CLI in */usr/local/bin/sfdx*. <br>
Update to newest version with `sfdx update`. <br>
**script:** sfdx/sfdx_scripts/sfdx_linux_installer automates this process on linux systems <br>

## oclif
*– the open cli framework* <br>

## api versin / runtime config
[CLI Runtime Configuration Values](https://developer.salesforce.com/docs/atlas.en-us.222.0.sfdx_dev.meta/sfdx_dev/sfdx_dev_cli_config_values.htm?search_text=runtime) <br>
`sfdx force:config:set apiVersion=42.0 --global` will set the used api version to 42. <br>
`sfdx force:config:set apiVersion= --global` will set it back to current version. <br>
`sfdx force:config:list` will show a list of overridden configs. Default config doesn't show. <br> 

## environment variables
[Environment Variables](https://developer.salesforce.com/docs/atlas.en-us.222.0.sfdx_dev.meta/sfdx_dev/sfdx_dev_cli_env_variables.htm?search_text=runtime) <br>

## creating a new project
`sfdx force:project:create -n Demo1` will create new project **Demo1** as a sub-directory of the working directory. <br>
Open project folder in *VS Code* (<kbd>CTRL</kbd> + <kbd>o</kbd>). <br>
The **sfdx-project.json** was created with the global set **api version**. The **login url** can be edited here. <br>
## org authentication
`sfdx force:auth:web:login -a Demo1` will open production org web-login to authenticate the cli. <br>
To authenticate a **Sandbox** or **Custom Domain** use `sfdx force:auth:web:login -a Demo1 --instanceurl https://test.salesforce.com` <br>
If the authentication via web login doesn't work, try `sfdx force:auth:device:login -a Demo1` <br>
## open org
To open an authenticated org type `sfdx force:org:open -u Demo1` or `sfdx force:org:open -u 0221@myforce.net` <br>
**Demo1** is the org **alias**, *0221@myforce.net* is the *user name* – both work fine. <br>
So it makes absolutely sense to use `-a Demo1` option with **:auth** to give your orgs short and descriptive aliases. <br>
## org overview
List all your authenticated orgs with `sfdx force:auth:list` <br>
```sh
=== authenticated orgs
ALIAS  USERNAME          ORG ID              INSTANCE URL                                 OAUTH METHOD
─────  ────────────────  ──────────────────  ───────────────────────────────────────────  ────────────
Demo1  0221@myforce.net  00D09000007FkECEA0  https://myforcenet-dev-ed.my.salesforce.com  web
```

