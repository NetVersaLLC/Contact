require 'rubygems'
require 'sinatra'
require 'haml'
require 'securerandom'
require 'yaml'
require 'mysql2'
require 'fileutils'
require 'json'

environment=ENV['RAILS_ENV'] == 'production' ? 'production' : 'development'
DB_CONFIG = YAML::load(File.open('config/database.yml'))[environment]
mysql = Mysql2::Client.new(:host       => DB_CONFIG['host'],
                           :username   => DB_CONFIG['username'],
                           :password   => DB_CONFIG['password'],
                           :port       => DB_CONFIG['port'],
                           :database   => DB_CONFIG['database'])

get "/list.json" do
  entries = []
  Dir.open('uploads').each do |ent|
    next if ent[0] == '.' or ent =~ /\.solution$/
    next if File.exists? "uploads/#{ent}.solution"
    entries.push ent
  end
  entries.to_json
end

get '/' do
  @rows = ['one']
  haml :captchas
end

get "/captcha/:file" do
  file = "./uploads/#{params[:file]}"
  if file =~ /png$/
    content_type 'image/png'
  elsif file =~ /jpg$/
    content_type 'image/jpeg'
  elsif file =~ /gif$/
    content_type 'image/gif'
  else
    error 404
  end
  File.read file
end

post '/solve.json' do
  content_type :json
  file = params[:file]
  text = params[:text]
  filename = "./uploads/#{file}"
  solution = "#{filename}.solution"
  puts "Writing: #{solution} with: #{text}"
  if File.exists? filename
    File.open(solution, "w") do |f|
     f.write text
    end
  else
    error 404
  end
  {:status => 'updated'}.to_json
end

# Handle POST-request (Receive and save the uploaded file)
post "/upload.json" do
  content_type :json
  uuid = SecureRandom.uuid
  token = params[:auth_token]
  escaped = mysql.escape(token)
  results = mysql.query "SELECT id FROM users WHERE authentication_token='#{escaped}'"
  puts "Results: #{results.count}"
  results.each do |row|
    puts "Result: #{row.inspect}"
  end
  if results.count == 0
    error 403
  end
  type = params[:file][:type]
  if type == 'image/jpeg'
    ext = 'jpg'
  elsif type == 'image/gif'
    ext = 'gif'
  elsif type == 'image/png'
    ext = 'png'
  else
    error 403
  end
  filename = "./uploads/#{uuid}.#{ext}"
  puts "Incoming request: #{filename}"
  FileUtils.cp(params[:file][:tempfile].path, filename)
  current = 0
  solution = "#{filename}.solution"
  while current < 120
    if File.exists? solution
      break
    end
    current += 1
    sleep 1
  end
  resp = {}
  if File.exists? solution
    resp[:solution] = File.read solution
    resp[:status]   = "solved"
    FileUtils.rm filename
    FileUtils.rm solution
  else
    resp[:status]   = "timeout"
    FileUtils.rm filename
  end
  resp.to_json
end
