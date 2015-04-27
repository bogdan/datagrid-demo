class Grid < ActiveRecord::Base

  default_scope -> { order("grids.created_at desc") }

  validates_presence_of :name, :code

  def file=(file)
    self.code = file.read
  end

  def to_s
    name
  end
end
