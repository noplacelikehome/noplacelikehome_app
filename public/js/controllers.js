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

  }]);