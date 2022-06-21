class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :content
      t.references :item, foreign_key: true
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
