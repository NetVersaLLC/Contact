module ApplicationHelper
  def show_notice(message,subtext)
    @message = message
    @subtext = subtext
    render :partial => 'pages/alert'
  end
  def show_notices(alert,notice)
    logger.info "Alert: #{alert}"
    if alert
      show_notice(alert, '')
    end
    logger.info "Notice: #{notice}"
    if notice
      show_notice(notice, '')
    end
  end
end
