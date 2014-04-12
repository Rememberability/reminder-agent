var app = angular.module('app', ['ngResource', 'ui.bootstrap']);

app.factory("Item", function($resource) {
  return $resource("/api/v1/items/:id", {id: "@id"},
   {
     "remember": {method: "PUT", url: "/api/v1/items/:id/remember", params: { id: "@id"} },
     "forget": {method: "PUT", url: "/api/v1/items/:id/forget", params: { id: "@id"} }
   }
  );
});

app.controller('ItemCtrl', function ($scope, Item, $filter) {

  $scope.data = { "question": "", "answer": ""};

  $scope.items = Item.query();

  $scope.create = function(question, answer) {
    Item.save({question: question, answer: answer}, function(item) {
      $scope.items.push(item);
      $scope.data = {};
      $scope.items = $filter('orderBy')($scope.items, 'reminder_date');
    });
  };

  $scope.delete = function(index) {
    Item.delete({id: $scope.items[index].id}, function() {
      $scope.items.splice(index, 1);
    });
  };

  $scope.remember = function(index) {
    Item.remember({id: $scope.items[index].id}, function(item) {
      $scope.items[index].reminder_date = item.reminder_date;
      $scope.items = $filter('orderBy')($scope.items, 'reminder_date');
    });
  };

  $scope.forget = function(index) {
    Item.forget({id: $scope.items[index].id}, function(item) {
      $scope.items[index].reminder_date = item.reminder_date;
      $scope.items = $filter('orderBy')($scope.items, 'reminder_date');
    });
  };

  $scope.need_reminding = function(item) {
    if ((Date.parse(item.reminder_date) + 86400000) < Date.now()) {
      return true;
    } else {
      return false;
    }
  };
});
