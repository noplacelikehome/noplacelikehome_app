"use strict";

var appControllers = angular.module("appControllers", []);

noPlaceLikeHome.controller("FormController", ["$scope", "$http", "$timeout",
  function($scope, $http, $timeout){

    $scope.formData = {}

    // $scope.formData = {
    // //!!!! For testing purposes only, leave commented out when committing or pushing to production
    //   yearly_income: 45000,
    //   offer_price: 25000,
    //   current_monthly_rent: 2000,
    //   street_address: "725 Leavenworth St",
    //   zip: 94109,
    //   bedrooms: 3
    // };

    // $scope.recommendedOffer = {
    // //!!! For testing purposes only, leave commented out when committing or pushing to production
    //     high_difference_in_months: 38,
    //     high_offer: 154500.0868,
    //     high_total_after_taxes: 103515.05815599998,
    //     low_difference_in_months: 12,
    //     low_offer: 50000,
    //     low_total_after_taxes: 33500,
    //     orig_difference_in_months: 6,
    //     orig_total_after_taxes: 16750,
    //     original_offer: 25000
    //   }

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