#!/bin/bash
rm -r output
pelican content
pelican --listen
