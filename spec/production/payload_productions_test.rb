require File.dirname(__FILE__) + '/../spec_helper'

describe 'Test Production Payloads' do
  describe "rerun the bing/signup if it fails 3 times" do
    it 'should run specified payloads for test businesses successfully' do

      @machines= {:windows7=> 604, :windows8=> 780, :windowsvista=> 779, :windowsxp=> 203}
      # NOTE: change this payloads if needed
      @payloads= ["Bing/Signup","Cylex/AddListing", "Twitter/SignUp"]

      start_time, wait_minutes= Time.now, 10
      fjobs, cjobs, jobs= [], [], []

      del_query= "business_id in (#{@machines.values.join(',')}) and name in ('#{@payloads.join("','")}') and created_at > DATE_SUB(NOW(), INTERVAL #{wait_minutes*1.5} MINUTE)"
      FailedJob.delete_all(del_query)
      CompletedJob.delete_all(del_query)
      Job.delete_all(del_query)

      @payloads.each do |payload|
        @machines.each do |name,bid|
          b= Business.find(bid)
          jobs<< Payload.add_to_jobs(b, payload)
        end
        query= "business_id in (#{@machines.values.join(',')}) and name='#{payload}' and created_at > DATE_SUB(NOW(), INTERVAL #{wait_minutes} MINUTE)"
        while Job.where(query).count != 0
          sleep 10
          if Time.now > start_time + wait_minutes.minutes
            start_time= Time.now
            break
          end
        end

        fjobs<< FailedJob.where(query).to_a
        cjobs<< CompletedJob.where(query).to_a
      end


    end

  end

end