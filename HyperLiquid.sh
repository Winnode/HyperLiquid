#!/bin/bash

echo "====================================================="
echo "                  Welcome to WinSnip                  "
echo "====================================================="


adduser hl
usermod -aG sudo hl

echo "Please set a password for the 'hl' user and press ENTER to accept the default values."


su - hl <<'EOF'

# Update and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

# Install Screen
sudo apt-get install screen -y

# Download Peers
curl https://binaries.hyperliquid.xyz/Testnet/initial_peers.json > ~/initial_peers.json

# Create configuration files
echo '{"chain": "Testnet"}' > ~/visor.json
curl https://binaries.hyperliquid.xyz/Testnet/non_validator_config.json > ~/non_validator_config.json

# Download Binary
curl https://binaries.hyperliquid.xyz/Testnet/hl-visor > ~/hl-visor && chmod a+x ~/hl-visor

# Start a Screen session
screen -S hl -dm

# Launch Node
screen -S hl -p 0 -X stuff '~/hl-visor\n'

echo "The node will not display any message. You can now exit your Screen session by pressing CTRL+A+D."

EOF
