class Device < ActiveRecord::Base
  belongs_to :album
  after_save :initialize_data

  def has_read(id)
    self.read["read"] << id
  end

  private

  def initialize_data
    self.read = {:read => []}
  end
end
