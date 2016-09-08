function retry {
  local retry_max=$1
  shift

  local count=$retry_max
  while [ $count -gt 0 ]; do
    "$@" && break
    count=$(($count - 1))
    sleep 1
  done

  [ $count -eq 0 ] && {
    echo "Retry failed [$retry_max]: $@" >&2
    return 1
  }
  return 0
}
