(function() {
  'use strict';
  angular
    .module("NarrowItDownApp", [])
    .controller("NarrowItDownController", NarrowItDownController)
    .service("MenuItemsService", MenuItemsService)
    .directive("foundItems", FoundItemsDirective)
    .constant("ApiBasePath", "http://davids-restaurant.herokuapp.com")

  function FoundItemsDirective() {
      var ddo = {
        templateUrl: "/foundItems.html"
      };
      return ddo;
  };

  NarrowItDownController.$inject = ["MenuItemsService"];
  function NarrowItDownController(MenuItemsService) {
    var narrowIt = this;
    narrowIt.menuItems = [];
    narrowIt.searchByDescription = function(searchIt) {
      var promise = MenuItemsService.getMenuItems();
      promise.then(function(response) {
        narrowIt.menuItems = response.data.menu_items;
      })
      .catch(function(error) {
        console.log(error);
      });
    };
  };

  MenuItemsService.$inject = ["$http", "ApiBasePath"];
  function MenuItemsService($http, ApiBasePath) {
    var service = this;
    service.getMenuItems = function() {
      var response = $http({
        method: "GET",
        url: ApiBasePath + "/menu_items.json"
      });
      return response;
    };
  };
}())
