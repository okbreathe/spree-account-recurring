module Spree
  module Api
    module V1
      class SubscriptionsController < Spree::Api::BaseController
        before_action :find_active_plan, only: [:create]
        before_action :find_plan, only: [:destroy]
        before_action :find_subscription, only: [:destroy]

        def index
          authorize! :index, Subscription

          @subscriptions = current_api_user.subscriptions.undeleted.all

          respond_with(@subscriptions)
        end

        def create
          authorize! :create, Subscription

          @subscription = @plan.subscriptions.build(subscription_params.merge(user_id: current_api_user.id))

          if @subscription.save_and_manage_api
            respond_with(@subscription, status: 201, default_template: :show)
          else
            invalid_resource!(@subscription)
          end
        end

        def destroy
          authorize! :destroy, @subscription

          if @subscription.save_and_manage_api(unsubscribed_at: Time.current)
            respond_with(@subscription, status: 204)
          else
            invalid_resource!(@subscription)
          end
        end

        private

        def subscription_params
          params.require(:subscription).permit(:email, :card_token)
        end

        def find_active_plan
          unless @plan = Spree::Plan.active.where(id: params[:plan_id]).first
            return render('plan_not_found', status: 403)
          end
        end

        def find_plan
          unless @plan = Spree::Plan.where(id: params[:plan_id]).first
            return render('plan_not_found', status: 403)
          end
        end

        def find_subscription
          unless @subscription = @plan.subscriptions.undeleted.where(id: params[:id]).first
            return render('subscription_not_found', status: 403)
          end
        end
      end
    end
  end
end
