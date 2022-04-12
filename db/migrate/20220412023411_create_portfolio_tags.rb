class CreatePortfolioTags < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_tags do |t|
      t.integer :portfolio_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
