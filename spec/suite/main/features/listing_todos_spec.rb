# frozen_string_literal: true

RSpec.feature "Showing a ToDo", :web, :db do
  scenario "lists todo items" do
    todo = Factory[:todo, title: "RubyConf Talk"]

    visit "/"

    expect(page).to have_content("RubyConf Talk")

    click_on "RubyConf Talk"

    expect(page).to have_content("Todo \##{todo.id}")
  end
end
