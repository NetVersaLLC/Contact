class ReportFeedback < ActiveRecord::Base
  belongs_to :report

  attr_accessible :message, :report_id
end
