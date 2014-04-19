require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})

		options[:title] ||= "My todo list title"
		options[:description] ||= "My todo list description"
		options[:button] ||= "Create Todo list"

		visit "/todo_lists"
		click_link "New Todo list"

		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button options[:button]
	end

	it "Redirects to the todo list index page on success" do
		
		create_todo_list

		expect(page).to have_content "My todo list"

	end

	it "Displays an error when the todo list has no title" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list description")

	end

	it "Displays an error when the todo list has a title less than 3 characters" do

		expect(TodoList.count).to eq(0)

		create_todo_list title: "hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list description")

	end

	it "Displays an error when the todo list has no description" do

		expect(TodoList.count).to eq(0)

		create_todo_list description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list title")

	end

	it "Displays an error when the todo list has a description less than 4 characters" do

		expect(TodoList.count).to eq(0)

		create_todo_list description: "one"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list title")

	end
end