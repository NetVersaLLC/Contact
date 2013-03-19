class Spinach::Features::ManageResellers < Spinach::FeatureSteps
  step ': I am on the sign up page' do
    visit new_user_registration_path
  end

  step ': I fill in "Email" with "reseller@somewhitelabel.com"' do
    pending 'step not implemented'
  end

  step ': I fill in "Password" with "12345Xdsu"' do
    pending 'step not implemented'
  end

  step ': I fill in "Verify Password" with "12345Xdsu"' do
    pending 'step not implemented'
  end

  step ': I click "Sign Up"' do
    pending 'step not implemented'
  end

  step ': I should see "Welcome Reseller"' do
    pending 'step not implemented'
  end
end
