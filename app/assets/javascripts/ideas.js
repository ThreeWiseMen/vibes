function VoteViewModel() {
    self = this;
    this.kind = 0;
    this.idea_id = -1;
    this.user_id = -1;
}

ko.applyBindings(new VoteViewModel())
