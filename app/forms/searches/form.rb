module Searches
  class Form
    include Virtus
    
    attribute :keyword,   String
    attribute :user_name, String
    attribute :board_id,  Integer
    
    def result(scope = Forums::Post.all)
      keyword_search(scope).search(user_name_eq: user_name, topic_board_id_eq: board_id).result
    end
    
    
    private
      def keyword_search(scope)
        keyword.blank? ? scope : scope.search_by_text(keyword)
      end
    
  end
end