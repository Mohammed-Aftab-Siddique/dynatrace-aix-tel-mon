#!/bin/ksh

# Adjustable variables
TARGET_FILE="/opt/dynatrace/aix/targets.txt"
DT_TENANT_URL="<Tenant URL>"
DT_API_TOKEN="<API Token with ingest.metric priviledge>"
METRIC_ENDPOINT="$DT_TENANT_URL/api/v2/metrics/ingest"
HOST_IP="<Source IP>"
TIMEOUT=5

# Path and permission
PATH=/usr/bin:/bin
export PATH
umask 077

# Check if target file exists
if [ ! -f "$TARGET_FILE" ]; then
  echo "Target file not found!"
  exit 1
fi

while IFS=',' read TARGET PORT
do
  START_TIME=$(date +%s)
  
  TMP_FILE="/opt/dynatrace/aix/telnet_${TARGET}_${PORT}_$$.log"
  
  (
    echo quit
    sleep 1
  ) | telnet $TARGET > $TMP_FILE $PORT 2>&1 &
  
  PID=$!
  sleep $TIMEOUT
  kill $PID >/dev/null 2>&1
  wait $PID 2>/dev/null

  END_TIME=$(date +%s)
  DURATION=$((END_TIME - START_TIME))

  STATUS=0

  grep "Connected" $TMP_FILE >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    STATUS=1
  fi
echo $STATUS
  rm -f $TMP_FILE
  
  METRIC="custom.telnet.check,source=${HOST_IP},target=${TARGET},port=${PORT},time=${DURATION} $STATUS"

  curl -ks -X POST "$METRIC_ENDPOINT" -H "Authorization: Api-Token $DT_API_TOKEN" -H "Content-Type: text/plain" --data-binary "$METRIC"
done < "$TARGET_FILE"

exit 0
