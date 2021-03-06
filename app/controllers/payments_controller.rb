class PaymentsController < ActionController::Base
  include OffsitePayments::Integrations

  def paypal_ipn
    notify = Paypal::Notification.new(request.raw_post)
    order = ProductOrder.pending.find_by_ref(notify.item_id)

    if notify.acknowledge
      begin
        if order.price == notify.gross and notify.complete?
          order.set_paid!
          logger.info("Successfully paid through paypal. Original request: #{request.raw_post.inspect}")
        else
          logger.error("Failed to verify Paypal's notification, please investigate. Order id: #{order.id}")
        end
      rescue Exception => e
        logger.error "Exception caught in PAYPAL IPN: #{e}"
      end
    end
    render :nothing => true
  end
end
