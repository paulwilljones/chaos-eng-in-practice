#!/usr/bin/env bash

chaos run create-a-new-nodepool-and-swap-to-it.json

chaos report --export-format=pdf journal.json report.pdf
