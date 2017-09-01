class AddStripeCustomerIdToSpreeUsers < ActiveRecord::Migration
  def change
    add_column Spree.user_class.to_s.pluralize.downcase.to_sym, :stripe_customer_id, :string
    remove_column :spree_subscriptions, :card_customer_token, :string
  end
end
