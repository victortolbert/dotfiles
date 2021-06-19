boxstart() {
    redis-server /usr/local/etc/redis.conf
    mysql.server start
}
boxstop() {
    redis-cli shutdown
    mysql.server stop
}
