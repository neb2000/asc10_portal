module Messages
  module Compose
    class Form < Messages::Base::Form
      attribute :recipient, String
      
      validates :recipient, presence: true
      
      def save
        sender.send_message recipient_user, self.topic, self.body
      end
      
      private
        def recipient_user(klass = User)
          @recipient_user ||= klass.find_by_name(recipient)
        end
    end
  end
end