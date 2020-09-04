class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :friends
  has_many :likes
  has_many :liked_tweets, :through => :likes, :source => :tweet
# def arr_friends_id
#  self.friends.pluck(:friend_id)
# end
# def admin
#   if self.admin == true
#     true
#   else
#    false
#  end
# end

  def users_followed
    arr_ids= self.friends.pluck(:friend_id)
    User.find(arr_ids)
  end

  def is_following?(user)
    users_followed.include? (user)
  end

  def friends_count
    self.friends.count
  end

  def tweets_count
    self.tweets.where(rt_ref: nil).count
  end

  def likes_give_it
    self.likes.count
  end

  def retweets_give_it
    self.tweets.where.not(rt_ref: nil).count

  end

end
