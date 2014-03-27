define(['jquery', 'knockout', 'models/user', 'models/idea'], function($, ko, User, Idea) {
  function IdeaListViewModel() {
    var self = this;

    this.ideas = ko.observableArray();

    this.navigateToIdea = function(idea) {
      console.log(idea);
    };

    $.ajax({
      url: '/api/ideas',
      success: function(data) {
        $.each(data, function(index, ideaData) {
          self.ideas().push(new Idea(ideaData));
        });
      }
    });
  }

  return new IdeaListViewModel();
});
