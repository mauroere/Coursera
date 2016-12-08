(function() {
  'use strict';
  angular
    .module("ShoppingListCheckOff", [])
    .service("ShoppingListCheckOffService", ShoppingListCheckOffService)
    .controller("ToBuyController", ToBuyController)
    .controller("AlreadyBoughtController", AlreadyBoughtController);

  ToBuyController.$inject = ["ShoppingListCheckOffService"];
  function ToBuyController(sh) {
    this.buyItem = function(index) {
      sh.buy(index);
    };
    this.items = sh.toBuyItems;
  };

  AlreadyBoughtController.$inject = ["ShoppingListCheckOffService"];
  function AlreadyBoughtController(sh) {
    this.items = sh.boughtItems;
  };

  function ShoppingListCheckOffService() {
    var toBuy = [
      {name: "One", quantity: 1},
      {name: "Two", quantity: 2},
      {name: "Three", quantity: 3},
      {name: "Four", quantity: 4},
      {name: "Five", quantity: 5}];
    var bought = [];
    this.buy = function(index) {
      bought.push(toBuy[index]);
      delete toBuy[index];
      toBuy.splice(index, 1);
    }
    this.toBuyItems = toBuy;
    this.boughtItems = bought;
  };
}())
