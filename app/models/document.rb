class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :author
  field :body
  field :rating, :type => Integer
end
