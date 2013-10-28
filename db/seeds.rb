User.delete_all

justin = User.create({first_name: 'Justin', last_name: 'Wood',
                       email: 'woodjk@threewisemen.ca', password: 'something',
                     about_me: 'This is a small description about me'})
