class PdfReport

  def self.generate_pdf(business)
    logo, title, address1, address2, phone = header_data(business)
    account_table_data = account_data(business)
    complete_table_data = completed_job_data(business)
    tmp_file = ''

    Prawn::Document.new do 
      
      top_y_position = cursor

      bounding_box( [0, cursor], :width => 200, :height => 100) do
        image(logo, :fit => [200,100]) if File.exist?(logo)
      end

      bounding_box( [200, top_y_position], :width => 320, :height => 100) do
        move_down 15
        text(title, :size => 16, :style => :bold, :align => :center)
        move_down 15
        text(address1, :size => 10, :align => :center)
        text(address2, :size => 10, :align => :center)
        text(phone, :size => 10, :align => :center)
      end

      move_down 20
      text('Site Account Information', :size => 14, :style => :bold) 
   
      table(account_table_data, :header => true, :row_colors => ['FAF9F5','FFFFCC']) do        
        row(0).font_style = :bold
        row(0).background_color = 'A6A6A6'
      end 

      start_new_page()
      text('Completed Jobs Information', :size => 14, :style => :bold) 

      table(complete_table_data, :header => true, :row_colors => ['FAF9F5','FFFFCC']) do        
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

  def self.account_data(business)
        data = [ ['Site', 'Username', 'Passord','Other'] ]

        Business.citation_list.each do |site|
          if business.respond_to?(site[1]) and business.send(site[1]).count > 0
            business.send(site[1]).each do |thing|
              row = ['','','','']
              row[0] = site[3].to_s

              username = thing.username if thing.respond_to?('username') 
              username ||= thing.email if thing.respond_to?('email') 
              username ||= 'submitted' 
              password = thing.password if thing.respond_to?('password') 
              password ||= '' 
              row[1] = username.to_s
              row[2] = password.to_s 

              site[2].each do |name|
                next if %w(email username password).include?(name[1])

                if name[0] == 'text'
                  row[3] = thing.send(name[1]).to_s
                end
              end
            
              data.push row
            end
 		      else
            STDERR.puts "Nothing for: #{site[1]}" 
          end

        end # end of citation_list loop

        return data
  end

  def self.completed_job_data(business)
      data = [ ['Site', 'Status'] ]

      ran = {}
      CompletedJob.where(:business_id => business.id).each do |row|
        ran[row.name.split("/")[0]] = 'Completed'
      end
      ran.each_key do |site|
        data.push [site, 'Completed']
      end

      return data
  end
end
