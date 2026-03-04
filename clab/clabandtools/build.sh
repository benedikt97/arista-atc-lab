#!/bin/bash
cp ../../requirements.txt ./
podman build . -t clabandtools
