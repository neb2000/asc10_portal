module Topics
  module Base
    class Form
      include ActiveModel::Validations
      include Virtus
      
      attr_accessor :board, :user
      
      attribute :subject, String
      attribute :text,    String
      
      validates :subject, :text, :user, presence: true
      
      def assign_attributes(attributes, as = :default)
        self.attributes = attributes
      end
            
      def self.name
        'Topic'
      end
    end
  end
end