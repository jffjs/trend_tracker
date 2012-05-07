class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.string :query
      t.string :last_tweet
      t.belongs_to :user

      t.timestamps
    end
  end
end
