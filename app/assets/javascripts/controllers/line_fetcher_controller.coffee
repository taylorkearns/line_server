angular.module("LineFetcher").controller "LineFetcherController", [
  "$scope",
  "LineService"
  ($scope, LineService) ->
    $scope.fetchLine = ->
      promise = LineService.get($scope.lineNumber)
      promise.then (result) -> $scope.line = result.data
      promise.catch (error) -> $scope.line = error.data
]
