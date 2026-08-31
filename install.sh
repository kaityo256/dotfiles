#!/bin/sh

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

for source in "$script_dir"/dot.*; do
  [ -f "$source" ] || continue

  name=${source##*/dot}
  destination=${HOME}/${name}

  if [ -e "$destination" ] || [ -L "$destination" ]; then
    printf 'skip: %s already exists\n' "$destination"
    continue
  fi

  ln -s "$source" "$destination"
  printf 'linked: %s -> %s\n' "$destination" "$source"
done
