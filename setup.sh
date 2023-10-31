#!/bin/bash

# Run your setup code prior to the tool installations
# Setting up Symlinks 
/bin/bash ./hooks/setup.sh 


# Installing tools
echo "== Installing Gitleaks(github.com/gitleaks/gitleaks) =="
wget https://github.com/gitleaks/gitleaks/releases/download/v8.18.0/gitleaks_8.18.0_linux_x64.tar.gz -O /tmp/gitleaks.tar.gz;
tar -xzvf /tmp/gitleaks.tar.gz
mv gitleaks /usr/local/bin

# EOF