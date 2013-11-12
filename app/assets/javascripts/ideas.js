/* global ko */

function Idea(data) {
    this.id = ko.observable(data['id'] || -1);
    this.name = ko.observable(data['name'] || "");
    this.leader = ko.observable(data['leader'] || -1)
    this.description = ko.observable(data['description'] || "");
    this.userID = ko.observable(data['user_id'] || -1);
    this.createdAt = ko.observable(data['created_at'] || "");
}

function Vote(data) {
    this.id = ko.observable(data['id'] || -1);
    this.ideaID = ko.observable(data['idea_id'] || -1);
    this.userID = ko.observable(data['user_id'] || -1);
    this.kind = ko.observable(data['kind'] || 0);
}

function User(data) {
    this.id = ko.observable(data['id'] || -1)
}

function IdeaViewModel() {
    self = this;

    this.vote = ko.observable(new Vote({}));
    this.idea = ko.observable(new Idea({id: window.location.pathname.split('/')[2]}));
    this.user = ko.observable(new User({}));

    $.getJSON('/api/ideas/' + self.idea().id(), function(idea) {
        if (idea['error']) {

        } else {
            self.idea().id(idea['id']);
            self.idea().name(idea['name']);
            self.idea().leader(idea['leader']);
            self.idea().description(idea['description']);
            self.idea().userID(idea['userID']);
            self.idea().createdAt(idea['created_at']);
        }
    });

    $.getJSON('/api/users/current', function(user) {
        if (user['error']) {

        } else {
            console.log(user);
            self.user().id(user['id']);
        }
    });

    $.getJSON('/api/ideas/' + self.idea().id() + '/vote_for_current_user', function(vote) {
        if (vote['error']) {

        } else {
            self.vote().id(vote['id']);
            self.vote().userID(vote['user_id']);
            self.vote().ideaID(vote['idea_id']);
            self.vote().kind(vote['kind']);
        }

        console.log(self.vote().kind());
    });

    this.upvote = function() {
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
        });
    };

    this.downvote = function() {
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
        });
    };
};

ko.applyBindings(new IdeaViewModel());
