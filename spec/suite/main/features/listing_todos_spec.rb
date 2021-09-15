# frozen_string_literal: true

RSpec.feature "Listing ToDo's", :web, :db do
  scenario "lists todo items" do
    Factory[:todo, title: "RubyConf Talk"]

    visit "/"

    expect(page).to have_content("RubyConf Talk")
  end
end
