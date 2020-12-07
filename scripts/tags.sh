#!/bin/sh

image="$1"
shift
if [ "x$image" = "x" ] || [ "$image" = "--help" ]; then
    echo "Usage: $0 IMAGE"
    echo
    echo "Prints all tags associated with IMAGE in a docker repository"
    exit 1
fi

case "$image" in
*/*/*)
    host=${image%%/*/*}
    path=${image#*/}
    ;;
*/*)
    host=index.docker.io
    path=$image
    ;;
*)
    host=index.docker.io
    path=library/$image
    ;;
esac

tags_uri=https://$host/v2/$path/tags/list

##
## Figure out who hands out tokens by doing an unauthenticated request
##
extract() {
    # XXX: This can't handle values with commas in them
    echo -n "$2" | awk -v f="$1" 'BEGIN {RS=","; FS="=\"|\"$";} ($1 == f) { print $2; }'
}
auth=$(curl --silent -I $tags_uri | sed -n 's/^Www-Authenticate: Bearer //p' | tr -d '\r')
if [ -n "$auth" ]; then
    realm=$(extract realm "$auth")
    service=$(extract service "$auth")
    scope=$(extract scope "$auth")
    ## Now fetch a token
    token=$(curl --silent --get --data-urlencode "service=$service" --data-urlencode "scope=$scope" $realm | jq -r '.token')
    auth_header="Authorization: Bearer $token"
fi

## Finally, list versions
curl -s --header "$auth_header" "$tags_uri" | jq -r '.tags[]'
