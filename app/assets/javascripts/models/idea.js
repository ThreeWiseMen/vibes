define(['knockout'], function(ko) {
  function Idea(data) {
    this.id = ko.observable(data['id'] || -1);
    this.name = ko.observable(data['name'] || "");
    this.leader = ko.observable(data['leader'] || -1);
    this.description = ko.observable(data['description'] || "");
    this.userID = ko.observable(data['user_id'] || -1);
    this.createdAt = ko.observable(data['created_at'] || "");
    this.upVoteCount = ko.observable(data['upvote_count'] || 0);
    this.downVoteCount = ko.observable(data['downvote_count'] || 0);
    this.score = ko.observable(data['score'] || 0);
    this.comment_count = ko.observable(data['comment_count'] || 0);
  }
  return Idea;
});
