#!/bin/bash

CONFIG_PATH="$HOME/.config/zellij/config.kdl"

echo "$CONFIG_PATH" | entr -r zellij
