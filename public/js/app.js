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
      templateUrl: "templates/home.html",
      controller: "HomeController"
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

        // url will be /form/payment
        .state('form.eviction', {
            url: '/eviction',
            templateUrl: 'templates/form-eviction.html'
        });
});