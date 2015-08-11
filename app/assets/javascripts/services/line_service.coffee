angular.module("LineFetcher").service "LineService", [
  "$http",
  ($http) ->
    get: (lineNumber) ->
      $http.get "/api/lines/#{lineNumber}"
]
