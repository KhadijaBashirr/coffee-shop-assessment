class OrderCompletionJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    order.update(status: :completed)
    # Here you would typically send a notification to the customer
    # This could be an email, SMS, or a push notification depending on your setup
    Rails.logger.debug { "Order #{order_id} is ready for pickup!" }
  end
end
