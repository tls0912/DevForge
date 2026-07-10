#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$1"
}

if [[ "$(uname -s)" != "Linux" ]]; then
  echo 'This script must run inside WSL/Linux.' >&2
  exit 1
fi

log 'Updating Ubuntu package index...'
sudo apt-get update

log 'Installing base packages...'
sudo apt-get install -y \
  git \
  curl \
  wget \
  tree \
  jq \
  build-essential \
  p7zip-full \
  vim \
  nano \
  less \
  htop \
  dos2unix

log 'WSL base environment initialized.'
log 'Node.js、Java、.NET、Docker 與 Codex 將由獨立模組安裝。'
