User.delete_all
Idea.delete_all
Authentication.delete_all
Vote.delete_all

justin = User.create({first_name: 'Justin', last_name: 'Wood',
                       email: 'woodjk@threewisemen.ca', password: 'something',
                     about_me: 'This is a small description about me'})

other_user = User.create({first_name: 'Other', last_name: 'User',
                       email: 'rawr@rawr.com', password: 'something',
                       about_me: 'This is a small description about me'})

idea = Idea.create({name: 'Something Cool', leader: 'This is the leader of my idea',
                   description: 'This is the description of my idea. It is a really goo one',
                   user: justin})

Vote.create({user: justin, idea: idea, kind: 1})
