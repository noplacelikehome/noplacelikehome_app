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

    $scope.eviction = function(evictionBool) {
      $http.post('/api/evictions', {eviction: evictionBool}).success(function(response){
        console.log('bought out');
      });
    };

    $scope.summons = function(summonsBool) {
      $http.post('/api/summons', {summons: summonsBool}).success(function(response){
        console.log(response);
        alert('no u bought out');
      })
    }

  }]);