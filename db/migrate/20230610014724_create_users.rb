# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo, default: ''
      t.text :bio, default: ''
      t.timestamps
      t.integer :posts_counter, default: 0
    end
  end
end
