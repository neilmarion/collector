class Device < ActiveRecord::Base
  belongs_to :album

  def has_read(id)
    self.read = read.nil? ? "#{id}" : "#{read},#{id}"
    save!
  end
end
