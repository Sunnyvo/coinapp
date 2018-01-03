class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.belongs_to :platform, foreign_key: true
      t.belongs_to :coin, foreign_key: true
      t.float :worth

      t.timestamps
    end
  end
end
