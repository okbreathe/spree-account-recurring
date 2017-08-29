object @plan
cache [I18n.locale, @current_user_roles.include?('admin'), current_currency, root_object]

attributes *[:api_plan_id, :amount, :interval, :interval_count, :name, :currency, :recurring_id, :trial_period_days, :active, :deleted_at, :default]
