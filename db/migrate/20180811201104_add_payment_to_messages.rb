class AddPaymentToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :payment, foreign_key: true
  end
end
