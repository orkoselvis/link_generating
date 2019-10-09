# frozen_string_literal: true

class CreateLink < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url
      t.string :message
      t.string :encrypted_key
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
