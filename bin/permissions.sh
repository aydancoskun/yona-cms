#!/bin/bash

sudo chmod -R a+w src/data
sudo chmod -R a+w src/public/assets
sudo chmod -R a+w src/public/img
sudo chmod a+w src/public/robots.txt

echo "Permissions installed successfully!"