#!/bin/bash
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ghdir="${scriptdir%/*}"
basedir="${ghdir%/*}"

datadir="${basedir}/_data"

ff() {
  find "${datadir}" -mindepth 1 -type f | grep -E "${1}" | sort
}

val() {
  for el in $(ff "${1}"); do
    dasel -f "${el}" >/dev/null 2>&1 || {
      echo -e "\n[error] invalid file: ${el}"
      dasel -f "${el}"
      echo ""
      x=1
    }
  done
}

x=0
val "\.(csv|json|ya?ml|toml)$"
exit ${x}
