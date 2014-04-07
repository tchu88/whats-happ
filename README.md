# WhatsHapp [![Build Status](https://travis-ci.org/tchu88/whats-happ.svg?branch=master)](https://travis-ci.org/tchu88/whats-happ)

## Setup

0) Install Postgres

See http://postgresapp.com/

1) Install the dependencies and setup the databases

```console
git clone https://github.com/tchu88/whats-happ.git
cd whats-happ
bundle install
rake db:create
rake db:migrate
rake db:test:prepare
```

2) Setup up local environment variables in .env (see https://github.com/bkeepers/dotenv)

```console
cp .env.sample .env
```

Sign up for Twilio and set your TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, and TWILIO_FROM_NUMBER.

## Tests

Run the test suite with the default rake task.

```console
rake
```

## Deploy (Heroku)

0) Create an application

You must upgrade to a production level database to run the PostGIS extension. NOTE: this is not free.

```console
heroku create your-app-name
heroku addons:add heroku-postgresql:premium-yanari
```

2) Set environment variables

```console
heroku config:set SECRET_TOKEN=`bundle exec rake secret` \
	TWILIO_ACCOUNT_SID=youraccountsid \
	TWILIO_AUTH_TOKEN=yourauthtoken \
	TWILIO_FROM_NUMBER=yourphonenumber \
	TWILIO_MESSAGES_NAME=nameofyourchoosing \
	TWILIO_MESSAGES_PASSWORD=yourchoiceofsecurepassword
```

3) Set your Twilio messages request url

The `/messages` route is protected by HTTP Basic Authentication. The values of TWILIO_MESSAGES_NAME and TWILIO_MESSAGES_PASSWORD can be passed from Twilio in the url you control.

`https://nameofyourchoosing:yourchoiceofsecurepassword@your-app-name.herokuapp.com/messages`

4) Push the code base

```console
git push heroku master
heroku run rake db:migrate
```

5) Add publishers

Drop into the heroku console (`heroku run console`) and add publisher records.

6) Add the Heroku Scheduler addon

Once the addon is setup, visit the scheduler dashboard and schedule `rake update_streams` to run every 10 minutes or an interval of your choosing.

```console
heroku addons:add scheduler
```
