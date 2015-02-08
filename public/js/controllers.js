"use strict";

var appControllers = angular.module("appControllers", []);

noPlaceLikeHome.controller("HomeController", ["$scope", "$http", "$timeout",
  function($scope, $http, $timeout){

    $scope.click = function(){
      console.log("clicked")
    }

  }]);