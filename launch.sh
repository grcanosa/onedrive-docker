#!/bin/bash

docker run -it --restart always --name docker-onedrive -v "/mnt/DATA/onedrive/:/onedrive/" onedrive