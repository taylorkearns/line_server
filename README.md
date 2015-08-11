# Line Server

## Get it running
Run specs with Rspec
```
bundle exec rspec
```

Start Redis
```
redis-server
```

Start Rails
```
rails server
```

## How the system works
I'm using Redis as the data store. The source file (`data/lines.txt`) is loaded into Redis with `line:<line number>` as the key and the line as the value. The `RedisSourcer` class processes the data; the class gets run by an initializer when the app starts up, and can also be run with a Rake task.

A user enters a line number into the input field on the web page. There is a small Angular app composed of `LineFetcherController` and `LineService`, which takes the line number and makes a request to `Api::LinesController`. The controller requests the key from Redis. It returns a string containing the line, or if the line is outside the scope of the data, it returns a message to the user and raises an error.

## How the system will perform with large files
Should perform pretty well. If the source file is large it will take a little while for the data to initially get sucked into Redis. But after that, reading from Redis should be super fast.

## How the system will perform with many users
It's making asynchronous javascript requests from the browser, which won't lock up a user's page if there are a lot of requests for the same resource.

## Resources consulted
* Using Redis with Ruby on Rails http://jimneath.org/2011/03/24/using-redis-with-ruby-on-rails.html
* Ruby, Rails, Rspec, Angular documentation, StackOverflow

## Tools and libraries
* Redis as the data store
* Rails as the web framework
* Angular as the front end

## Time spent
About half a day to get everything working. I spent another hour or so making it look nice.

### What I would do with more time
* The javascript should have a test or two.

* The validations and errors for the line picker should be tightened up. Right now if a user enters a letter into the field it sends back a 413 error, which isn't accurate. Angular has simple pattern matching validations I could use.

* I was reading about doing mass inserts in Redis by writing out the exact protocol commands instead of performing `SET` commands for every line. http://redis.io/topics/mass-insert. I started to go down this road but bailed because I wasn't seeing it go much faster. Still I assume it is ultimately more efficient.

* It would be nice to be able to load any source file into the system.

* A spinner would be nice during the ajax request.

## Critiques
* Using the global `$redis` variable feels like a smell.
