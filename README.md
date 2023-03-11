# README

## Description
This is a simple app that allows to forward alerts from JSON payloads to a Slack channel.

## Installation
1. Create a Slack app and add it to your workspace, check here for more info: https://api.slack.com/apps/
2. Make sure the app has chat:write permissions
3. Create a channel called `#spam` and add the bot to it
4. Clone the repository
5. add the slack bot token to the .env file
6. Run `docker compose up -d` to start the app
7. wait until the app boots up and is ready to receive requests
8. send a POST request to the app with the following payload:
```bash
curl --location --request POST 'localhost:3000/alerts' \
--header 'Content-Type: application/json' \
--data-raw '{
  "RecordType": "Bounce",
  "Type": "SpamNotification",
  "TypeCode": 512,
  "Name": "Spam notification",
  "Tag": "",
  "MessageStream": "outbound",
  "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
  "Email": "zaphod@example.com",
  "From": "notifications@alerts.io",
  "BouncedAt": "2023-02-27T21:41:30Z"
}'
```
Check your Slack channel for the alert, it should be sent to a channel called `#spam`