#!/usr/bin/env bash

source test/setup

use Test::More tests 5
use JSON

tree1=$(cat test/test1.json | JSON.load)
ok $?                           "JSON.load succeeded"

is "$(JSON.get '/id' tree1)" \
    '12345678' \
    "JSON.get works on first element"

JSON.put '/id' 314159 tree1
JSON.put -s '/id2' "foo bar" tree1

is "$(JSON.get '/id' tree1)" \
    '314159' \
    "JSON.get after put"

tree1="$(echo "$tree1" | JSON.put '/id' 42)"
is "$(JSON.get '/id' tree1)"  \
    '42' \
    "JSON.get after put"

JSON.put '/nested/ele/ment' 23 tree1
is "$(JSON.get '/nested/ele/ment' tree1)" \
    '23' \
    "JSON.get /nested/ele/ment"
