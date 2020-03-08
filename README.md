# OctoPrint-docker

This repository contains everything you need to run [Octoprint](https://github.com/foosel/OctoPrint) in a docker environment.

# Getting started

```bash
git clone https://github.com/dogukancagatay/docker-octoprint.git && cd docker-octoprint

# Search for you 3D printer serial port (usually it's /dev/ttyUSB0 or /dev/ttyACM0)
ls /dev | grep tty

# Edit the docker-compose file to set your 3D printer serial port
vim docker-compose.yml

docker-compose up -d
```

You can then go to http://localhost:5000

You can display the log using `docker-compose logs -f`

## Without docker-compose
```bash
docker run -d -v ./config:/data --device /dev/ttyUSB0:/dev/ttyUSB0 -p 5000:5000 --name octoprint dcagatay/octoprint:latest
```

Adapted from [https://github.com/OctoPrint/docker](https://github.com/OctoPrint/docker)
