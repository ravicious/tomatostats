class Project < ActiveRecord::Base
  belongs_to :user
  has_many :pomodoros, dependent: :nullify
  validates_presence_of :name, :user
  validates_uniqueness_of :name, scope: :user

  def to_s
    name
  end

  def self.sorted_by_name
    order("name ASC")
  end
end
