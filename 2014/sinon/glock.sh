#!/usr/bin/env bash
cc -O0 run.c -o run > /dev/null && ./run | tee run.c
