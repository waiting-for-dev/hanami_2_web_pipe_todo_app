# frozen_string_literal: true

RSpec.feature "Creating a ToDo", :web, :db do
  scenario "edits a todo" do
    Factory[:todo, title: "RubyConf Talk"]
    visit "/"
    click_on "RubyConf Talk"
    click_on "Edit"

    fill_in "Title", with: "Wash dishes"
    fill_in "Description", with: "Dishwasher is broken, do it manually"
    click_on "Save"

    expect(page).to have_content("Item updated successfully")
    expect(page).to have_content("Wash dishes")
  end

  scenario "validation errors" do
    todo = Factory[:todo, title: "RubyConf Talk"]
    visit "/todos/#{todo.id}"
    click_on "Edit"

    fill_in "Title", with: ""
    click_on "Save"

    expect(page).to have_content("must be a string")
  end
end
