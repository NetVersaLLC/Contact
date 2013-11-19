class DashboardController < ApplicationController
  before_filter      :authenticate_user!

  def index 
    @dashboard = Dashboard.new( current_user )
    sql = "select count(id) as 'count',date(created_at) as 'date' from reports 
      where created_at > DATE_SUB(CURDATE(), INTERVAL 3 MONTH) 
        and label_id = #{current_label.id}
      group by date(created_at) order by id desc"
    @scan_reports = Report.connection.select_all( sql )
  end 

end 
