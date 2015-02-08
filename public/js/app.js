"use strict";

var noPlaceLikeHome = angular.module("noPlaceLikeHome", [
  "ngRoute",
  "appControllers"
  ]);

noPlaceLikeHome.config(["$routeProvider",
  function($routeProvider){
    $routeProvider.
      when("/home", {
        templateUrl: "templates/home.html",
        controller: "HomeController"
      }).
      otherwise({
        redirectTo: "/"
      });
}]);