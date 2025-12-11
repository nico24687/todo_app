# frozen_string_literal: true

# Task model representing a to-do item with priority levels and completion status
class Task < ApplicationRecord
  # Priority levels as a hash for easy reference
  PRIORITIES = {
    low: 1,
    medium: 2,
    high: 3
  }.freeze

  # Reverse lookup for display purposes
  PRIORITY_NAMES = PRIORITIES.invert.transform_values { |v| v.to_s.capitalize }.freeze

  # Validations
  validates :title, presence: { message: "can't be blank - every task needs a title!" }
  validates :title, length: { maximum: 100, message: "is too long (maximum is 100 characters)" }
  validates :priority, inclusion: { in: PRIORITIES.values, message: "must be Low, Medium, or High" }

  # Scopes for filtering
  scope :completed, -> { where(completed: true) }
  scope :active, -> { where(completed: false) }

  # Scopes for sorting
  scope :by_due_date, -> { order(Arel.sql("CASE WHEN due_date IS NULL THEN 1 ELSE 0 END, due_date ASC")) }
  scope :by_priority, -> { order(priority: :desc) }
  scope :by_created_at, -> { order(created_at: :desc) }

  # Set default values before validation on create
  before_validation :set_defaults, on: :create

  # Helper method to get priority name
  def priority_name
    PRIORITY_NAMES[priority] || "Unknown"
  end

  # Helper method to check if task is overdue
  def overdue?
    due_date.present? && due_date < Date.current && !completed?
  end

  # Helper method to check if task is due soon (within 2 days)
  def due_soon?
    due_date.present? && due_date <= 2.days.from_now.to_date && due_date >= Date.current && !completed?
  end

  private

  def set_defaults
    self.completed = false if completed.nil?
    self.priority ||= PRIORITIES[:medium]
  end
end
