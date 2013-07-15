class Scan < ActiveRecord::Base
  belongs_to :report

  def site_name
    Business.citation_list.each do |row|
      if row[0] == self.site
        return row[3]
      end
    end
    return self.site
  end
end
