#!/bin/sh

set -e

pesde run roblox_sync_config_generator

rojo serve build.project.json \
   & blink default.blink --watch \
   & darklua process --config .darklua.json5 --watch src/ out/