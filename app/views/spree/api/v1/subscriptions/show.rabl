object @subscription
cache [I18n.locale, @current_user_roles.include?('admin'), current_currency, root_object]

attributes *[:plan_id, :email, :user_id, :subscribed_at, :unsubscribed_at]
