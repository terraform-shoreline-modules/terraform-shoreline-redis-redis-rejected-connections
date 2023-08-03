

#!/bin/bash



# Set the Redis configuration file path

REDIS_CONF_PATH=${PATH_TO_REDIS_CONF}



# Increase the max number of connections

sed -i 's/maxclients ${VALUE}/maxclients 10000/g' $REDIS_CONF_PATH



# Tune the eviction policies

sed -i 's/eviction-policy ${VALUE}/eviction-policy allkeys-lru/g' $REDIS_CONF_PATH



# Restart the Redis service

systemctl restart redis