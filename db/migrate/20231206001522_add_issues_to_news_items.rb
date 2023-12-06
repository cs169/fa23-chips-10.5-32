class AddIssuesToNewsItems < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :issue, :string, null: false, default: ''
  end
end
