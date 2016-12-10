# Diamonds, kali-linux-web-cli

This is the Vagrant and Docker build folder for the "kali-linux-web" toolset.

```shell
# build and launch with Vagrant
vagrant up



# build in Docker
docker build --force-rm --no-cache=true -t apolloclark/kali-linux-web-cli .

# launch with Docker
docker run -dit diamonds/kali-linux-web-cli

# attach to the running Bash instance
docker attach $(docker ps -qf "ancestor=apolloclark/kali-linux-web-cli" | tail -n +2 | cut -f 1)
```
