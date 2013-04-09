Feature: Edit Business Form
  In order to allow our customers to edit their business profile.
  As a signed in user.
  I want to edit a business.

  Scenario: Autocomplete City by Zipcode
    Given: I am on the edit business page.
    When: I enter "92626" in Search by Zip.
    And: I select a different form element.
    Then: I should see "Costa Mesa" in City and "California" in State.

  Scenario: Get Business Results From Company Search
    Given: I have entered my city and state.
    When: I enter "Kaiten" in Company Name.
    And: I click "Search".
    Then: I should see "Kaisen Kaiten".

  Scenario: Populate Form From Business Results
    Given: I have performed an autocomplete search and have results.
    When: I click "Select" next to "Kaisen Kaiten".
    Then: I should see "Kaisen Kaiten" in Business Name.
    And: I should see "714-444-2161" in Local Phone.
    And: I should see "3855 S Bristol St" in Address.

  Scenario: View Business Details
    Given: I am on the edit business page.
    When: I first arrive on the page.
    Then: I should see "Step 1: Business Details".
    And: I should see "Business Name"
    And: I should see "Local Phone"

  Scenario: Entering Bad Data
    Given: I am on the edit business page.
    When: I enter "777-777-777" into the "Local Phone" field.
    And: I change to a different field.
    Then: I should see "is invalid" next to "Local Phone"
    And: "Local Phone" should be highlighted red.

  Scenario: Editing Payment Methods
    Given: I am on the edit business page.
    When: I click on "Step 2: Payment Methods"
    Then: I should see "Mastercard"
    And: I should see "Cash"

  Scenario: Editing Business Hours
    Given: I am on the edit business page.
    When: I click on "Step 3: Business Hours"
    Then: I should see "Monday"
    And: I should see "Tuesday"

  Scenario: Editing Categories
    Given: I am on the edit business page.
    When: I click on "Step 4: Select Categories"
    Then: I should see "Category 1"
    And: I should see "Category 2"
    And: I should see "Category 3"

  Scenario: Editing Images
    Given: I am on the edit business page.
    When: I click "Step 5: Manage Images"
    Then: I should see "Upload Images"

  Scenario: Uploading an Image
    Given: I am on the edit business page.
    And: I have selected "Step 5: Manage Images"
    When: I click "Upload Images"
    And: I select an image to upload.
    Then: I should see the uploaded image.

  Scenario: Uploading Images
    Given: I am on the edit business page.
    And: I have selected "Step 5: Manage Images"
    When: I click "Upload Images"
    And: I select several images to upload.
    Then: I should see the uploaded images.

  Scenario: Selecting a Logo
    Given: I am on the edit business page.
    And: I have selected "Step 5: Manage Images"
    When: I click on a image.
    Then: I should see "Set this image as your logo?"

  Scenario: Details Are Saved When User Changes Tab
    Given: I am on the edit business page.
    When: I enter "Test Business" in the Business Name field.
    And: I click "Step 4: Select Categories".
    And: I sign out and sign back in.
    And: I go to the edit business page.
    Then: I should see "Test Business" in the Business Name field.

  Scenario: Cannot Change Tab When Data Is Invalid
    Given: I am on the edit business page.
    When: I enter "777-777 1212" in the Local Phone field.
    And: I click "Step 4: Select Categories"
    Then: I should see "is invalid" next to Local Phone.
    And: I should still be on the "Step 1: Business Details" tab.

  Scenario: Saving Profile Before It Validates As Complete
    Given: I have filled out the Business Details tab and nothing else.
    When: I click "Save Profile".
    Then: I should see "Cannot Save Business Until Profile is Complete"

  Scenario: Saving a Completed Profile
    Given: I have filled out a complete business profile.
    When: I click "Save Profile".
    Then: I should see "Pfofile Saved".
    And: I should be on the business dashboard page.