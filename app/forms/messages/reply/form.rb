module Messages
  module Reply
    class Form < Messages::Base::Form
      attribute :reply_to, Integer
      
      validates :reply_to, presence: true
      
      def save
        sender.reply_to message, self.topic, self.body
      end
      
      private
        def message(klass = ActsAsMessageable::Message)
          @message ||= klass.find_by_id(reply_to)
        end
    end
  end
end