module Spree
  module Api
    module V1
      class PlansController < Spree::Api::BaseController
        def index
          @plans = Spree::Plan.visible.order('id desc')
          respond_with(@plans)
        end
      end
    end
  end
end
