#!/bin/bash

# rerun_i3status() {
#     if [[ -v $i3statusPID ]]; then
#         kill "$i3statusPID"
#     fi
#     i3status && export i3statusPID=$!;
# }

# entr bash -c "if [[ -v $i3statusPID ]]; then kill \"$i3statusPID\"; fi;  if [[ -v $i3statusPID ]]; then kill $i3statusPID; fi; i3status && export i3statusPID=$!;" < <(find ~/.dotfiles/i3/.config/i3status/ -name "config")

# if [[ -v $i3statusPID ]]; then
#     kill "$i3statusPID"
# fi
# i3status && export i3statusPID=$!;

