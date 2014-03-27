define(['knockout'], function(ko) {
  function User(data) {
    this.id = ko.observable(data['id'] || -1);
  }
  return User;
});
