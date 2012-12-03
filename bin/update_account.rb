#!/usr/bin/env ruby

require 'rest_client'

@host = 'http://localhost:3000'
@key = ARGV.shift
@bid = ARGV.shift

email = 'somebody@somwhere.com'
password = 'secretpass'

RestClient.post "#{@host}/accounts.json?auth_token=#{@key}&business_id=#{@bid}", 'account[email]' => email, 'account[password]' => password, 'model' => 'AngiesList'
