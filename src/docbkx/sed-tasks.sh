#!/bin/bash

find . -name "*.xml" -exec sed -i -f tasks.sed {} \;

