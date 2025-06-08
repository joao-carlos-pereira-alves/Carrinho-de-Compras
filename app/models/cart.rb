class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy

  scope :active, -> { where(abandoned: false) }
  scope :abandoned, -> { where(abandoned: true) }

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  ABANDONED_THRESHOLD = 3.hours
  REMOVAL_THRESHOLD = 7.days

  def abandoned?
    abandoned
  end

  def mark_as_abandoned!
    update!(abandoned: true)
  end

  def abandoned_for_too_long?
    abandoned? && last_interaction_at < REMOVAL_THRESHOLD.ago
  end

  def inactive_for_abandonment?
    !abandoned? && last_interaction_at < ABANDONED_THRESHOLD.ago
  end

  def remove_if_abandoned!
    destroy! if abandoned_for_too_long?
  end

  def add_product(product_id, quantity)
    item = cart_products.find_or_initialize_by(product_id: product_id)
    new_quantity = item.persisted? ? item.quantity + quantity.to_i : quantity.to_i
    item.quantity = new_quantity
    item.save
    update_column(:last_interaction_at, Time.current)
    item
  end
end
