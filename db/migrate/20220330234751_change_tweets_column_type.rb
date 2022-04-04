class ChangeTweetsColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :tweets, :content, :text
  end
end
