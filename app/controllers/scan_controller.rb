class ScanController < ApplicationController
  def start
    @name        = params[:name].strip
    @zip         = params[:zip].strip
    @phone       = params[:phone].strip
    @package_id  = params[:package_id]
    @ident       = SecureRandom.uuid
    @report      = Report.generate(@name,@zip,@phone,@package_id,@ident)
  end

  def check
    @result = {:status => :error, :message => "Report not found."}
    Report.where(:ident => params[:ident]).each do |report|
      if report.completed_at == nil
        @result = {:status => :running, :message => "Report is still being generated."}
      else
        @result = {:status => :finished, :message => "Report is ready."}
      end
    end
    render :json => @result
  end

  def show
    @report = Report.where(:ident => params[:id]).first
  end
end
