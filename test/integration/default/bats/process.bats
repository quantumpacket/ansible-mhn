#!/usr/bin/env bats

setup() {
    apt-get install -y curl >/dev/null || yum -y install curl >/dev/null
}

@test "process redis-server should be running" {
    run pgrep redis-server
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process mongod should be running" {
    run pgrep mongod
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process supervisord should be running" {
    run pgrep supervisord
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process nginx should be running" {
    run pgrep nginx
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process uwsgi should be running" {
    run pgrep uwsgi
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "process celery should be running" {
    run pgrep celery
    [ "$status" -eq 0 ]
    [[ "$output" != "" ]]
}

@test "Web interface should be accessible through nginx - https://localhost:50443/" {
    run curl -sSqk https://localhost:50443/
    [ "$status" -eq 0 ]
    [[ "$output" =~ "You should be redirected automatically to target URL" ]]
    [[ "$output" != "Internal Server Error" ]]
}

@test "Web interface should be accessible through nginx - https://localhost:50443/static/mhn.rules" {
    run curl -sSqk https://localhost:50443/static/mhn.rules
    [ "$status" -eq 0 ]
    [[ "$output" =~ "alert tcp " ]]
}

