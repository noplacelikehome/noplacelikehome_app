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

    $scope.yesBuyOut = function() {
      $http.post('/api/get_eviction_status', {eviction: true}).success(function(response){
        console.log(response);
        alert('yes u bought out');
      })
    }

    $scope.noBuyOut = function() {
      alert(formData);
    }

  }]);