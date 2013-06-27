module Topics
  module Create
    class Form < Topics::Base::Form
      def save
        return false unless valid?
        build_first_post
        topic.save
      end
            
      def build_first_post
        topic.posts.build(user: user, text: text)
      end      
      
      def topic(klass = Forums::Topic, datetime_class = Time)
        @topic ||= klass.new(board: board, user: user, subject: subject, last_post_at: datetime_class.now.utc)
      end
    end
  end
end