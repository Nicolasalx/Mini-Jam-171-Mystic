#!/bin/sh
echo -ne '\033c\033]0;Mini-Jam-171-Mystic\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Mini-Jam-171-Mystic.x86_64" "$@"
