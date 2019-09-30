# Cinema Booking

This Ruby application allows you to create bookings for movies.

## Requirements
 * Ruby 2.5.1 or higher
 * PostgreSQL
 
## Run project locally

```
createdb cinema_booking
rake db:migrate
rake db:seed
rackup
```

* Seed creates customers with ids 1,2,3

## Run local tests
```
createdb cinema_booking_test
rake db_test:config
rspec
```

## Heroku online documentation URL

https://rocky-beyond-49922.herokuapp.com/doc

## Enpoints

### Create Movie

Allows to create movies in the system and associate them to the days a week in which they are being shown

* Example
```
curl -X POST \
  https://rocky-beyond-49922.herokuapp.com/api/v1/movies \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
  "name":"Movie one",
  "description":"The best",
  "url": "url",
  "days": ["monday", "tuesday", "sunday"]
}'

```

Responses

* `201` http code for successfully transaction
```
'Movie created'
```
* `400` http code for error


### Get movies by day

Returns movies that are being shown given one week day.

* Example

```
curl -X GET \
  https://rocky-beyond-49922.herokuapp.com/api/v1/movies/sunday \
  -H 'Cache-Control: no-cache'
```

Responses

* `200` http code for successfully transaction with body
```
{
    "movies": [
        {
            "name": "Movie one",
            "description": "The best",
            "url": "url"
        }
    ]
}
```
* `400` http code for error


## Create booking 

Receive valid movie_id and valid customer_id,likewise, you can only make a booking for a movie for the day it is shown

* Example

```
curl -X POST \
  https://rocky-beyond-49922.herokuapp.com/api/v1/bookings \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
  "movie_id": 1,
  "customer_id": 1,
  "date": "2019-08-04"
}'
```

Responses

* `201` http code for successfully transaction
```
`Booking created`
```
* `400` http code for error

Restrictions

* There is a limit of 10 booking per show

## Get bookings by dates

Returns a list of Booking, given a date range

* Example

```
curl -X GET \
  'https://rocky-beyond-49922.herokuapp.com/api/v1/bookings?from=2018-08-01&to=2019-08-30' \
  -H 'Cache-Control: no-cache'
```

Responses

* `200` http code for successfully transaction with body

```
{
    "bookings": [
        {
            "booking_id": 1,
            "movie": {
                "name": "Movie one",
                "description": "The best",
                "url": "url"
            },
            "customer": {
                "name": "Wilson",
                "document_type": "cc",
                "document": "123456"
            },
            "booking_date": "2019-08-04"
        }
    ]
}
```

* `400` http code for error

## Author
Wilson Valencia (wilval7126@gmail.com)
