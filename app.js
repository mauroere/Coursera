(function() {
  'use strict';
  angular
    .module('NameCalculator', [])
    .controller('NameCalculatorController', function($scope) {
      $scope.name = "";
      $scope.totalValue = 0;

      $scope.updateTotal = function() {
        var totalValue = calculateTotal();
        $scope.totalValue = totalValue;
      };

      var calculateTotal = function() {
        return 999;
      };
    });
})();
