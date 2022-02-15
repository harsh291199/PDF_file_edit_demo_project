class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :fname
      t.text :b_name

      t.timestamps
    end
  end
end
