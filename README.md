## docker-jts3servermod
Java 8 JRE with JTS3Servermod.

### Summary
* Java 8 JRE and latest version of JTS3Servermod
* The configuration can be injected to the host:
  * /config
  * /plugins
  
## Usage
The default UID of the user which is used in the container is 1000.
So if you mount a directory from your host you have to set the permissions to the user with the UID of 1000.
```
useradd -u 1000 jts3servermod
chown -R jts3servermod {FOLDER}
```
	
#### Mount Host-directory
```
docker run --name jts3servermod -d -v {FOLDER}:/home/jts3servermod raaaimund/docker-jts3servermod:latest
```
                                              
### SELinux
If your host uses SELinux it may be necessary to use the **:z** option:
```
docker run --name jts3servermod -d -v {FOLDER}:/home/jts3servermod:z raaaimund/docker-jts3servermod:latest
```