

#!/bin/bash



# Set variables

${PORT_NUMBER}="PLACEHOLDER"

${PROTOCOL}="PLACEHOLDER"

${FIREWALL_RULE_NAME}="PLACEHOLDER"



# Add firewall rule to open port

sudo firewall-cmd --permanent --add-port=$PORT_NUMBER/$PROTOCOL --zone=public --permanent --name=$FIREWALL_RULE_NAME

sudo firewall-cmd --reload



# Verify firewall rule is added

sudo firewall-cmd --list-all