#!/usr/bin/env bash

echo "SILENT NOTIFICAION TEST"

curl --location --request POST 'https://fcm.googleapis.com/fcm/send' \
--header 'Authorization: key=AAAAGPrfo9s:APA91bHK0lHCMtBkKPvHjvsQHfSK_wpVlCcStT8q9EatoM41lTsOliQD5msbBq19uusS02TAykq5V3hbkXOHip8io8GK5T4CGhDl4mALeHTN9MKtrKskLEejepuOqZKS5AHRBicy7qg7' \
--header 'Content-Type: application/json' \
--data-raw '{
 "to" : "fkDEVO3K9U6ClohoqYOHuh:APA91bGqxYcUqE0jaAqeHLT4MwPBGCtDP-L8DCNv1K1g6U31RQQnbSchXIGqF5ZC1yPci2oUn4GDcCB0IHufFjA5gURhh3wgk-c-24RAmgg2_K1EpUFu40cWN1bK596QbnaYRZmGazg-",
 "content_available": true,
  "apns-priority": 5,
  "data": {
    "some-key": "some-value"
  }
}'

echo
