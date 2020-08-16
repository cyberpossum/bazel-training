#!/bin/bash

function fail {
    echo "${1}" >&2
    exit 1
}

function test_query {
    QUERY="${1:?query is required}"
    MD5SUM="${2:?MD5 sum is required}"
    ERRMSG="${3:?error message is required}"
    GREP="${4:-^.*$}"
    [ "$(bazel query "${QUERY}" 2>/dev/null|grep "${GREP}"|sort|md5sum|cut -f1 -d' ')" = "${MD5SUM}" ] || fail "${ERRMSG}"
}