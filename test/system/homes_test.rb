require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit homes_url
  #
  #   assert_selector "h1", text: "Home"
  # end
  test "visiting the home" do
    visit "/"

    assert page.has_content?("Comment ca marche ?")
    assert_selector "h1", text: "Nos clients témoignent"
    # take_failed_screenshot
  end
end
