Sequel.seed do
  def run
    [
        %w[Wilson cc 123456],
        %w[David cc 654321],
        %w[Juan cc 352363],
    ].each do |name, document_type, document|
      Customer.create name: name, document_type: document_type, document: document
    end
  end
end
