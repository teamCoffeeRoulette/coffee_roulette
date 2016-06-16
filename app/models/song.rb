class Song < ActiveRecord::Base

  belongs_to :users
  has_many :upvotes

end
