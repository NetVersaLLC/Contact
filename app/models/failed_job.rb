class FailedJob < JobBase
  belongs_to :business
  belongs_to :screenshot

  def has_screenshot? 
    screenshot.present? && screenshot.data.present?
  end 
end
