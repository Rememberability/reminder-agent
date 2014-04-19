var app = angular.module('app', ['ngResource', 'ui.bootstrap']);

app.config(function($httpProvider) {
  var authToken = $("meta[name='csrf-token']").attr("content");
  return $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
});

app.factory("Item", [ "$resource", function($resource) {
  return $resource("/items/:id", {id: "@id"},
		   {
     "remember": {method: "PUT", url: "/items/:id/remember", params: { id: "@id"} },
     "forget": {method: "PUT", url: "/items/:id/forget.json", params: { id: "@id"} }
   }
  );
}]);

app.controller('UserCtrl', ["$scope", "Item", "$filter", function ($scope, Item, $filter) {

  $scope.data = { "question": "", "answer": ""};

  $scope.items = Item.query(function() {
    for(item in $scope.items) {
      item.showAnswer = false;
    }
  });

  $scope.toggleShowAnswer = function(index) {
    $scope.items[index].showAnswer = !$scope.items[index].showAnswer;
  };

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
}]);
