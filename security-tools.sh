#!/bin/bash

echo "== Installing Gitleaks(github.com/gitleaks/gitleaks) =="
wget https://github.com/gitleaks/gitleaks/releases/download/v8.18.0/gitleaks_8.18.0_linux_x64.tar.gz -O /tmp/gitleaks.tar.gz;
tar -xzvf /tmp/gitleaks.tar.gz
mv gitleaks /usr/local/bin

# EOF