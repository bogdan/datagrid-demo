class DocumentReport

  include Datagrid

  scope do
    Document.desc(:created_at)
  end

  column :title 
  column :author 
  column :rating 
  column :created_at do
    self.created_at.to_date
  end

  filter :rating, :enum, :select => 0..10
  filter :title, :header => "Title (contains)" do |value|
    where(:title => /#{Regexp.escape(value)}/i)
  end
  filter :author, :header => "Author (regexp)" do |value|
    begin
      where(:author => Regexp.compile(value))
    rescue RegexpError
      where
    end
  end
end
