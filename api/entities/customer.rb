module Api
  module Entities
    class Customer < Grape::Entity
      expose :name,
             documentation: {
                 type: String,
                 desc: 'customer name'
             }
      expose :document_type,
             documentation: {
                 type: String,
                 desc: 'document type'
             }
      expose :document,
             documentation: {
                 type: String,
                 desc: 'document number'
             }
    end
  end
end
