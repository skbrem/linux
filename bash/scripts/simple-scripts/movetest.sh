#!/bin/bash

tar --zstd -cvf ~/Downloads/test-directory/personal.tar.zst -C ~/Downloads/Personal/ . &&
  tar --zstd -cvf ~/Downloads/test-directory/professional.tar.zst -C ~/Downloads/Professional/ .
