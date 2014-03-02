var app = angular.module('app', ['ngResource', 'ui.bootstrap']);

app.factory("Item", function($resource) {
  return $resource("/api/v1/items/:id");
});

app.controller('ItemCtrl', function ($scope, Item) {

  $scope.data = { "question": "", "answer": ""};

  $scope.items = Item.query();

  $scope.create = function(question, answer) {
    Item.save({question: question, answer: answer}, function(item) {
      $scope.items.push(item);
      $scope.data = {};
    });
  };

  $scope.delete = function(index) {
    Item.delete({id: $scope.items[index].id}, function() {
        $scope.items.splice(index, 1);
    });
  };

});
