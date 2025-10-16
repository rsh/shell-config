#!/usr/bin/env bash

cd ./home
stow -t ~ .
sudo stow -t /etc etc

