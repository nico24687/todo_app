# frozen_string_literal: true

# Clear existing tasks
Task.destroy_all

# Sample tasks for development
tasks = [
  {
    title: "Complete Rails project setup",
    description: "Set up the new Rails 7 application with Tailwind CSS and configure the development environment.",
    due_date: Date.current + 1.day,
    priority: 3,
    completed: true
  },
  {
    title: "Design the task list UI",
    description: "Create a modern, clean interface using Tailwind CSS with proper spacing, colors, and typography.",
    due_date: Date.current + 2.days,
    priority: 3,
    completed: false
  },
  {
    title: "Implement CRUD operations",
    description: "Build out all create, read, update, and delete functionality for tasks with proper validations.",
    due_date: Date.current + 3.days,
    priority: 2,
    completed: false
  },
  {
    title: "Add filtering and sorting",
    description: "Allow users to filter tasks by completion status and sort by various criteria like due date and priority.",
    due_date: Date.current + 4.days,
    priority: 2,
    completed: false
  },
  {
    title: "Review weekly goals",
    description: "Take time to review progress on weekly goals and adjust priorities as needed.",
    due_date: Date.current - 1.day,
    priority: 1,
    completed: false
  },
  {
    title: "Learn something new today",
    description: "Spend 30 minutes learning a new programming concept or technique.",
    due_date: nil,
    priority: 1,
    completed: false
  },
  {
    title: "Prepare presentation slides",
    description: "Create slides for the upcoming team meeting about project progress.",
    due_date: Date.current + 7.days,
    priority: 2,
    completed: true
  }
]

tasks.each do |task_attrs|
  Task.create!(task_attrs)
end

puts "Created #{Task.count} sample tasks!"
