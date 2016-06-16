class CreateReviews < ActiveRecord::Migration

  create_table :reviews do |t|
    t.references :user
    t.references :song
    t.string     :review_title
    t.string     :review_body
    t.timestamps
  end

end
