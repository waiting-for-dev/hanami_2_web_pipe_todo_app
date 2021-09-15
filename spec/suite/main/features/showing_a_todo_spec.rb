# frozen_string_literal: true

RSpec.feature "Listing ToDo's", :web, :db do
  scenario "shows a ToDo item" do
    todo = Factory[:todo, title: "RubyConf Talk", description: "Get ready for the talk"]

    visit "/todos/#{todo.id}"

    expect(page).to have_content("RubyConf Talk")
    expect(page).to have_content("Get ready for the talk")
  end

  scenario "doesn't found a Todo item" do
    visit "/todos/1"

    expect(page).to have_content("Not found")
  end
end
