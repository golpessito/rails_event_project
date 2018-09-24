class Event < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  before_save :ensure_start_at_date_is_soon_than_end_at_date


  #Event creator
  belongs_to :user

  #Users assitants
  has_many :rsvps, dependent: :restrict_with_error
  #has_many :attendances, through: :rsvps
  has_many :attende, through: :rsvps

  #Paper Clip Photo Upload
  has_attached_file :photo, styles: {medium: "800x400", thumb: "460x230"},
                    default_url: "/images/:style/missing.png"

  #Validations

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  validates :name, presence: true, uniqueness: 'has already been taken'
  validates :address, presence: true
  validates :description, presence: true
  validates :photo_file_name, presence:true
  validates :start_at, presence:true
  validates :end_at, presence:true
  validates :photo_file_name, allow_blank: true, format: {  with: %r{\.(gif|jpg|png)\Z}i, message: 'must be a GIF, JPG or PNG image.'}

  def self.get_event_one_day_before_start
    where(start_at:  Time.now + 1.day .. Time.now + 2.day).all
  end

  private
    def ensure_login_has_a_value
      if login.nil?
        self.login = email unless email.blank?
      end
    end

    def ensure_start_at_date_is_soon_than_end_at_date
      if end_at < start_at
        errors.add(:base, "Ensure your end at date is later than your start at date")
        throw :abort
      end
    end

end
