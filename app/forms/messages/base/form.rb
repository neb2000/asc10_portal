module Messages
  module Base
    class Form
      include ActiveModel::Validations
      include Virtus

      attr_accessor :sender
      
      attribute :topic,     String
      attribute :body,      String
      
      validates :topic, :body, presence: true
      
      def assign_attributes(attributes, as = :default)
        self.attributes = attributes
      end
       
      def self.name
        'Message'
      end
       
    end
  end
end