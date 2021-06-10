class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :user, foreign_key: true
      t.references :link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
