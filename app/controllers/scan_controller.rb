class ScanController < ApplicationController
  def start
    @name        = params[:name].strip
    @zip         = params[:zip].strip
    @phone       = params[:phone].strip
    @email       = params[:email]
    @referral    = params[:referrer_code]
    @package_id  = params[:package_id]
    @ident       = SecureRandom.uuid
    @report      = Report.where(:business => @name, :zip => @zip, :phone => @phone).order(:created_at).last
    if @report != nil and @reportb.created_at.to_datetime > (Time.now - 1.days)
      redirect_to "/scan/#{@report.ident}"
    else
      @report      = Report.generate(@name,@zip,@phone,@package_id,@ident,current_label,@email,@referral)
    end
  end

  def check
    @result = {:status => :error, :message => "Report not found."}
    Report.where(:ident => params[:ident]).each do |report|
      if report.completed_at == nil
        message = "Report is still being generated."
        scan = report.scans.last
        if scan
          message = "Checking #{scan.site}..."
        end
        @result = {:status => :running, :message => message}
      else
        @result = {:status => :finished, :message => "Report is ready."}
      end
    end
    render :json => @result
  end

  def show
    @report = Report.where(:ident => params[:id]).first
  end

  def email
    @report = Report.where(:ident => params[:ident]).first
    @report.email = params[:email]
    @report.save!
    res = {:status => 'updated'}
    render :json => res
  end

  def send_email
    @report = Report.where(:ident => params[:ident]).first
    @report.email = params[:email]
    @report.save!
    flash[:notice] = 'Report has been sent'
    ReportMailer.report_email(@report).deliver
    redirect_to "/scan/#{@report.ident}"
  end

end
