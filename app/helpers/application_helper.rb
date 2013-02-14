module ApplicationHelper
  def current_label
    label = Label.where(:domain => request.host).first
    unless label
      label = Label.first
    end
    label
  end
  def show_notice(message,subtext)
    @message = message
    @subtext = subtext
    logger.info "Displaying: #{message}"
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
