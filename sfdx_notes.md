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

`sfdx plugins --core`
