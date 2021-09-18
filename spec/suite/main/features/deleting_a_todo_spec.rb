# frozen_string_literal: true

RSpec.feature "Deleting a ToDo", :web, :db do
  scenario "deletes a todo" do
    todo = Factory[:todo, title: "RubyConf Talk"]
    visit "/todos/#{todo.id}"

    expect(page).to have_content("RubyConf Talk")

    click_on "Delete"

    expect(page.current_path).to eq("/")
    expect(page).to have_content("Item successfully deleted")
    expect(page).not_to have_content("RubyConf Talk")
  end
end
