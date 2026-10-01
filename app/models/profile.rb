class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, length: { maximum: 100 }, allow_blank: true
  validates :about, length: { maximum: 2000 }, allow_blank: true
  validates :phone_number, length: { maximum: 50 }, allow_blank: true,
                           format: { with: /\A[\d\s+\-().]+\z/, message: 'no es válido', allow_blank: true }
  validate :birthday_not_in_future

  private

  def birthday_not_in_future
    # Legacy column typo `bithday` kept for migration chain stability.
    return if bithday.blank?
    errors.add(:bithday, 'no puede estar en el futuro') if bithday > Time.current
  end
end
