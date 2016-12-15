(function() {
  'use strict';
  angular
    .module("NarrowItDownApp", [])
    .controller("NarrowItDownController", NarrowItDownController)
    .service("MenuSearchService", MenuSearchService)
    .directive("foundItems", FoundItemsDirective)
    .constant("ApiBasePath", "https://davids-restaurant.herokuapp.com")

  function FoundItemsDirective() {
      var ddo = {
        scope: {
          items: '<',
          onRemove: "&"
        },
        templateUrl: "NarrowItDownApp/foundItems.html",
        controller: NarrowItDownController,
        controllerAs: 'list',
        bindToController: true
      };
      return ddo;
  };

  NarrowItDownController.$inject = ["MenuSearchService"];
  function NarrowItDownController(MenuSearchService) {
    var narrowIt = this;

    narrowIt.searchIt = "";
    narrowIt.menuItems = [];
    narrowIt.notFound = false;

    narrowIt.searchByDescription = function(searchIt) {
      var promise = MenuSearchService.getMatchedMenuItems(searchIt);
      promise.then(function(data) {
        narrowIt.menuItems = data;
        narrowIt.notFound = (narrowIt.menuItems.length === 0);
      });
    };

    narrowIt.removeItem = function(index) {
      narrowIt.menuItems.splice(index, 1);
    };
  };

  MenuSearchService.$inject = ["$http", "ApiBasePath"];
  function MenuSearchService($http, ApiBasePath) {
    var service = this;

    service.getMatchedMenuItems = function(searchTerm) {
      return $http({
        method: "GET",
        url: ApiBasePath + "/menu_items.json"
      })
      .then(function(response) {
        var menuItems = response.data.menu_items;
        console.log("Menu items: " + menuItems.length);
        var foundItems = [];
        menuItems.forEach(function(menuItem) {
          if (searchTerm.length > 0 && menuItem.description && menuItem.description.indexOf(searchTerm) != -1) {
            foundItems.push(menuItem);
          }
        });
        console.log("Found items: " + foundItems.length);
        return foundItems;
      });
    };
  };
}())
