class ApproveOrderJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 5

  def perform order
    UserMailer.approve_order(order).deliver_now
  end
end
