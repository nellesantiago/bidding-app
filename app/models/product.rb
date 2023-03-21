class Product < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates_presence_of :description, :starting_bid_price
  validates :name, presence: true, length: { in: 1..20 }

  validates_numericality_of :starting_bid_price, greater_than: 0

  enum bidding_status: { expired: 0, active: 1 }

  before_validation :set_default_expiration
  before_validation :expiration_date_cannot_be_in_the_past, on: :create

  def set_default_expiration
    self.bidding_expiration ||= 7.days.from_now
  end

  def expiration_date_cannot_be_in_the_past
    if self.bidding_expiration.present? && bidding_expiration < DateTime.current
      errors.add(:bidding_expiration, "can't be in the past")
    end
  end

  def is_resumable?
    self.bidding_expiration < DateTime.current
  end
end
