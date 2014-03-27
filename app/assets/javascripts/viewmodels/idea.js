define(['knockout', 'models/user', 'models/idea', 'models/vote', 'models/comment'], function(ko, User, Idea, Vote, Comment) {
  function IdeaViewModel() {
    self = this;

    this.vote = ko.observable(new Vote({}));
    this.idea = ko.observable(new Idea({id: window.location.pathname.split('/')[2]}));
    this.user = ko.observable(new User({}));

    updateIdea();
    window.setInterval(updateIdea, 60000);
    retrieveUser();
    retrieveVote();

    this.isUpVoteCastable = ko.computed(function() {
      return this.vote().kind() != 1
    }.bind(this));

    this.isDownVoteCastable = ko.computed(function() {
      return this.vote().kind() != -1
    }.bind(this));

    this.thumbIconClasses = function(direction, availability) {
      var directionyThumbs = {
        true: {
          true: 'fa-thumbs-o-up',
          false: 'fa-thumbs-up',
        },
        false: {
          true: 'fa-thumbs-o-down',
          false: 'fa-thumbs-down',
        }
      };

      var s = {
        'fa': 1,
        'fa-4x': 1
      };

      s['green'] = direction ? 1:0;
      s['red'] = direction ? 0:1;

      s['fa-flip-horizontal'] = direction ? 0:1;

      s[directionyThumbs[direction][availability]] = 1;
      s[directionyThumbs[!direction][availability]] = 0;
      s[directionyThumbs[direction][!availability]] = 0;
      s[directionyThumbs[!direction][!availability]] = 0;

      return s;
    }

    this.thumbUpIconClasses = ko.computed(function() {
      var c = this.thumbIconClasses(true, this.isUpVoteCastable());
      console.log("Thumb Up Classes");
      console.log(c);
      return c;
    }.bind(this));

    this.thumbDownIconClasses = ko.computed(function() {
      var c = this.thumbIconClasses(false, this.isDownVoteCastable());
      console.log("Thumb Down Classes");
      console.log(c);
      return c;
    }.bind(this));

    this.upvote = function() {
      if (self.isUpVoteCastable()) {
        $("#error").text('');
        $.getJSON("/api/ideas/" + self.idea().id() + "/upvote", function(data) {
          if (data['error']) {
            $("#error").text(data['error']);
          } else {
            self.vote().id(data['id']);
            self.vote().ideaID(data['idea_id']);
            self.vote().userID(data['user_id']);
            self.vote().kind(data['kind']);
          }
          updateIdea();
        });
      }
    };

    this.downvote = function() {
      if (self.isDownVoteCastable()) {
        $('#error').text('');
        $.getJSON("/api/ideas/" + self.idea().id() + "/downvote", function(data) {
          if (data['error']) {
            $("#error").text(data['error']);
          } else {
            self.vote().id(data['id']);
            self.vote().ideaID(data['idea_id']);
            self.vote().userID(data['user_id']);
            self.vote().kind(data['kind']);
          }
          updateIdea();
        });
      }
    };

    function updateIdea() {
        $.getJSON('/api/ideas/' + self.idea().id(), function(idea) {
            if (idea['error']) {

            } else {
                self.idea().id(idea['id']);
                self.idea().name(idea['name']);
                self.idea().leader(idea['leader']);
                self.idea().description(idea['description']);
                self.idea().userID(idea['userID']);
                self.idea().createdAt(idea['created_at']);
                self.idea().upVoteCount(idea['upvote_count']);
                self.idea().downVoteCount(idea['downvote_count']);
                self.idea().score(idea['score']);
            }
            console.log("UPDATED");
        });
    }

    function retrieveUser() {
        $.getJSON('/api/users/current', function(user) {
            if (user['error']) {

            } else {
                self.user().id(user['id']);
            }
        });
    }

    function retrieveVote() {
        $.getJSON('/api/ideas/' + self.idea().id() + '/vote_for_current_user', function(vote) {
            if (vote['error']) {

            } else {
                self.vote().id(vote['id']);
                self.vote().userID(vote['user_id']);
                self.vote().ideaID(vote['idea_id']);
                self.vote().kind(vote['kind']);
            }
        });
    }
  };

  return new IdeaViewModel();
});

