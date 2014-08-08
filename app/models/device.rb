class Device < ActiveRecord::Base
  belongs_to :album

  def has_read(id)
    self.read = unless read.nil?
      (read.split(',') | [id.to_s]).sort.join(',')
    else
      "#{id}"
    end

    save!
  end

  def reset_read
    self.read = nil
    save!
  end
end
