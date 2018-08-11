class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.text :note
      t.string :actor_name
      t.string :target_name
      t.text :actor_pic
      t.text :target_pic

      t.timestamps
    end
  end
end
