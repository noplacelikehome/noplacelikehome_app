"use strict";

var appControllers = angular.module("appControllers", []);

noPlaceLikeHome.controller("FormController", ["$scope", "$http", "$timeout",
  function($scope, $http, $timeout){

    $scope.formData = {}

    $scope.submitAddressInfo = function(formData){

      $http.post('/api/offer', formData).success(function(response){
        console.log(response);
        $scope.recommendedOffer = response;
      })

    }

    $scope.yesEviction = function() {
      $http.post('/api/evictions/', {eviction: true}).success(function(response){
        console.log(response);
        alert('yes u bought out');
      })
    }

    $scope.noEviction = function() {
      $http.post('/api/evictions/', {eviction: false}).success(function(response){
        console.log(response);
        alert('no u bought out');
      })
    }

    $scope.summons = function(summonsBool) {
      $http.post('/api/summons/', {summons: summonsBool}).success(function(response){
        console.log(response);
        alert('no u bought out');
      })
    }

  }]);