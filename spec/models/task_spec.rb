# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is invalid without a title" do
    task = Task.new(title: nil)
    expect(task.valid?).to be false
  end
end
