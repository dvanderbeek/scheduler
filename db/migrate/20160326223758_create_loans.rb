class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.timestamps null: false
    end
  end
end
