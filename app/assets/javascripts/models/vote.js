define(['knockout'], function(ko) {
  function Vote(data) {
    this.id = ko.observable(data['id'] || -1);
    this.ideaID = ko.observable(data['idea_id'] || -1);
    this.userID = ko.observable(data['user_id'] || -1);
    this.kind = ko.observable(data['kind'] || 0);
  }
  return Vote;
});
