class ApplicationGrid < Datagrid::Base

  def self.boolean_column(name, **options, &block)
    column(name, **options) do |model|
      value = block ? block.call(model) : model.public_send(name)
      format(value) do
        value ? 'Yes' : 'No'
      end
    end
  end

  def param_name
    :g
  end

end
