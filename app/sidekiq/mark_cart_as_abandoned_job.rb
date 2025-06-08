class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform(*args)
    mark_abandoned_carts
    remove_old_abandoned_carts
  end

  private

  def mark_abandoned_carts
    Cart.active.find_each do |cart|
      cart.mark_as_abandoned! if cart.inactive_for_abandonment?
    end
  end

  def remove_old_abandoned_carts
    Cart.abandoned.find_each(&:remove_if_abandoned!)
  end
end
