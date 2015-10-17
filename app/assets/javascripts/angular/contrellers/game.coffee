'use strict'

controller = angular.module('TicTacToe').controller 'GameController', ($scope, GameService) ->

  $scope.loading      = true
  $scope.current_user = true

  $scope.init = (id) ->
    GameService.get(id).then (resource) ->
      $scope.resource = resource.data
      $scope.loading  = false

    , (error) ->
      $scope.loading  = false
      # TODO

  $scope.tic = (item) ->
    $scope.resource.tic(item.row, item.column).then (data) =>
      item.value                   = data.value
      $scope.resource.current_user = data.user
      $scope.resource.win          = data.win
      $scope.resource.drawn        = data.drawn
      $scope.loading               = false
    , (error) ->
      $scope.loading  = false
      # TODO

controller.$inject = ['$scope', 'GameService'];
