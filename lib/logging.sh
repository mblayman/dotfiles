info () {
    printf "===> %s\n" "$1"
}

success () {
    printf "\033[0;32m===>\033[0m %s\n" "$1"
}

failure () {
    printf "\033[0;31m===>\033[0m %s\n" "$1"
    exit 1
}
