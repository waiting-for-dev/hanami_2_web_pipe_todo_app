# frozen_string_literal: true

RSpec.feature "Creating a ToDo", :web, :db do
  scenario "creates a todo" do
    visit "/"
    click_on "Create new"
    fill_in "Title", with: "Wash dishes"
    fill_in "Description", with: "Dishwasher is broken, do it manually"
    click_on "Save"

    expect(page).to have_content("Item created successfully")
    expect(page).to have_content("Wash dishes")
  end

  scenario "validation errors" do
    visit "/"
    click_on "Create new"
    fill_in "Description", with: "Dishwasher is broken, do it manually"
    click_on "Save"

    expect(page).to have_content("must be a string")
  end
end
