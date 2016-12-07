(function() {
  'use strict';
  angular
    .module("LunchCheck", [])
    .controller("LunchCheckController", LunchCheckController);

  LunchCheckController.$inject = ["$scope"];
  function LunchCheckController($scope) {
    $scope.consumeMenu = function() {
      var lunch = $scope.lunchMenu || "";
      var lunchItems = lunch.split(",");
      if (lunchItems.length > 3) {
        $scope.message = "Too much!";
        $scope.messageClass = "text-success";
      }
      else if (lunch.length > 0) {
        $scope.message = "Enjoy!";
        $scope.messageClass = "text-success";
      }
      else {
        $scope.message = "Please enter data first";
        $scope.messageClass = "text-danger";
      }
    };
  };
}());
