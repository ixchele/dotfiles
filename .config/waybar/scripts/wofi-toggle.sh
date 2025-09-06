#!/bin/bash
pgrep -x "wofi" || wofi --show drun --style ~/.config/wofi/config
