class Device < ActiveRecord::Base
  belongs_to :album
  after_save :initialize_data

  private

  def initialize_data
    self.read = []
  end
end
