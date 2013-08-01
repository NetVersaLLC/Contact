class PdfReport

  def self.generate_pdf(business)
    logo, title, address1, address2, phone = header_data(business)
    account_data, non_account_data = business.payload_status_data
    tmp_file = ''

    Prawn::Document.new do 
      
      top_y_position = cursor

      bounding_box( [0, cursor], :width => 200, :height => 150) do
        image(logo, :fit => [200,150]) if File.exist?(logo)
      end

      bounding_box( [200, top_y_position], :width => 320, :height => 150) do
        move_down 15
        text(title, :size => 16, :style => :bold, :align => :center)
        move_down 15
        text(address1, :size => 10, :align => :center)
        text(address2, :size => 10, :align => :center)
        text(phone, :size => 10, :align => :center)
      end

      move_down 20
      text('Sites with Account Username/Password', :size => 14, :style => :bold) 
   
      table(account_data, :header => true, :row_colors => ['FAF9F5','FFFFCC']) do        
        row(0).font_style = :bold
        row(0).background_color = 'A6A6A6'
      end 

      start_new_page()
      text('Status of Sites without Account Information', :size => 14, :style => :bold) 

      table(non_account_data, :header => true, :row_colors => ['FAF9F5','FFFFCC']) do        
        row(0).font_style = :bold
        row(0).background_color = 'A6A6A6'
      end 

      #create tmp file name
      c='abcdefghijklmnopqrstuvwxyz'
      setup = ''
      1.upto(10) do |i|
        setup += c[rand() * 26]
	    end
	    tmp_file  = Rails.root.join('tmp', "#{setup}.pdf")

      #	pdf.render_file tmp
      render_file tmp_file	
    end #end of pdf

    return tmp_file
  end 

private
  def self.header_data(business)
    raise 'The business object is not set' if business.nil?

    logo_partial_path = business.label.logo.url.split('?')[0].split('/')
    logo_partial_path.shift
    logo = Rails.root.join('public', logo_partial_path.join('/'))
    title = "#{business.business_name} Listing Report"
    address1 = "#{business.address} #{business.address2}"
    address2 = "#{business.city}, #{business.state} #{business.zip}"
    phone = business.local_phone


    return [logo, title, address1, address2, phone]
  end

end
