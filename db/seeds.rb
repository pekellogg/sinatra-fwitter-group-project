peyton = User.create(username: "Pey Pey", email: "peytonkellogg@gmail.com", password: "very,verysecure432!")
tweet_p1 = Tweet.new(content: "Wow, this is such a long and great tweet by me, yours truly.")
peyton.tweets << tweet_p1