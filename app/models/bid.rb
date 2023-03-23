class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :amount, presence: true

  after_validation :bid_amount

  def bid_amount
    if self.amount && self.product && self.amount < self.product.starting_bid_price
      errors.add(:amount, "should be greater than or equal to #{self.product.starting_bid_price}")
    end
  end

  scope :bid_winner, ->() { find_by(amount: self.maximum(:amount)) }
  scope :lowest_bid, ->() { minimum(:amount) }
end
