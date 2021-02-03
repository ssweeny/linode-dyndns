#!/bin/sh -e

TOKEN="$(snapctl get authtoken)"
DOMAIN_ID="$(snapctl get domainid)"
RESOURCE_ID="$(snapctl get resourceid)"

get_ip()
{
    # Get WAN IP from OpenDNS
    my_ip="$(dig @resolver3.opendns.com myip.opendns.com +short)"
    echo "$my_ip"
}

TARGET="$(get_ip)"

echo "Setting DNS record to ${TARGET}"

curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -X PUT -d "{
      \"target\": \"${TARGET}\"
    }" \
    https://api.linode.com/v4/domains/${DOMAIN_ID}/records/${RESOURCE_ID}
