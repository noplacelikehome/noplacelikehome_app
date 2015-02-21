"use strict";

var noPlaceLikeHome = angular.module("noPlaceLikeHome", [
  "ngRoute",
  "ui.router",
  "appControllers"
  ]);

noPlaceLikeHome.config(function($stateProvider, $urlRouterProvider) {
  //
// For any unmatched url, redirect to /state1
  $urlRouterProvider.otherwise("/");
  //
  // Now set up the states
  $stateProvider
    .state('home', {
      url: '/',
      templateUrl: "templates/home.html"
    })
    .state('form', {
      url: "/form",
      templateUrl: "templates/form.html",
      controller: "FormController"
    })
    .state('form.address', {
            url: '/address',
            templateUrl: 'templates/form-address.html'
        })

        // url will be /form/interests
        .state('form.offer', {
            url: '/offer',
            templateUrl: 'templates/form-offer.html'
        })

        .state('form.summons', {
            url: '/summons',
            templateUrl: 'templates/evictions/form-summons.html'
        })

        .state('form.resources', {
            url: '/resources',
            templateUrl: 'templates/evictions/form-resources.html'
        })

        .state('form.people', {
            url: '/people',
            templateUrl: 'templates/evictions/form-people.html'
        })

        .state('form.neighbors', {
            url: '/neighbors',
            templateUrl: 'templates/evictions/form-neighbors.html'
        })

        .state('form.neighbor_people', {
            url: '/neighbor_people',
            templateUrl: 'templates/evictions/form-neighbor-people.html'
        })

});