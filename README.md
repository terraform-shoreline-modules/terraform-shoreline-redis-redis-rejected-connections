
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Redis Rejected Connections Incident
---

This incident type refers to a situation where Redis, a popular in-memory data structure store, has rejected connections. This could happen due to various reasons such as server overload, network issues, or misconfiguration. When this occurs, it can cause disruptions in the performance of applications that rely on Redis for data storage or caching. Thus, it requires immediate attention and resolution to minimize the impact on the applications and users.

### Parameters
```shell
# Environment Variables

export REDIS_PORT="PLACEHOLDER"

export REDIS_HOST="PLACEHOLDER"

export PATH_TO_REDIS_CONF="PLACEHOLDER"

```

## Debug

### Check if Redis is running
```shell
systemctl status redis
```

### Check if Redis is listening on the correct port
```shell
sudo netstat -tuln | grep ${REDIS_PORT}
```

### Check Redis logs for any error messages
```shell
sudo tail -f /var/log/redis/redis-server.log
```

### Check the Redis client connections
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info clients
```

### Check the Redis memory usage
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info memory
```

### Check the Redis CPU usage
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} info cpu
```

### Check the Redis configuration
```shell
redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} config get *
```

### Check the system load and resource usage
```shell
top -c
```

### Check the network connectivity to Redis
```shell
ping ${REDIS_HOST}
```

### Check the firewall rules and open ports
```shell
sudo iptables -L -n
```

## Repair

### Update the firewall rules and open ports
```shell


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


```

### Optimizing Redis configuration settings such as increasing the max number of connections or tuning the eviction policies to avoid overload.
```shell


#!/bin/bash



# Set the Redis configuration file path

REDIS_CONF_PATH=${PATH_TO_REDIS_CONF}



# Increase the max number of connections

sed -i 's/maxclients ${VALUE}/maxclients 10000/g' $REDIS_CONF_PATH



# Tune the eviction policies

sed -i 's/eviction-policy ${VALUE}/eviction-policy allkeys-lru/g' $REDIS_CONF_PATH



# Restart the Redis service

systemctl restart redis


```