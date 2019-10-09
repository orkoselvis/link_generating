# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_190_924_081_706) do
  create_table 'links', force: :cascade do |t|
    t.string 'url'
    t.string 'message'
    t.string 'encrypted_key'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end
end
