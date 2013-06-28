module ApplicationForms
  class Form
    include ActionView::Helpers::UrlHelper
    include ActiveModel::Validations
    include Virtus
    
    attr_accessor :user, :board
    
    attribute :character_name,  String
    attribute :character_class, String
    attribute :character_spec,  String
    attribute :server_name,     String
    
    validates :character_name, :character_class, :character_spec, :server_name, presence: true
    
    def self.new_from_template(template)
      self.new.tap do |new_form|
        new_form.instance_eval do
          template.each_with_index do |section, section_index|
            section['questions'].each_with_index do |question, question_index|
              field_name = "q_#{section_index}_#{question_index}"
              structure[section['section_name']][field_name] = question['label']
              singleton_class.class_eval do
                attr_accessor field_name
                validates field_name, presence: true
              end
            end
          end
        end
      end
    end
    
    def assign_attributes(attributes, as = :default)
      attributes.each do |(key, val)|
        if self.respond_to?(:"#{key}=")
          self.send :"#{key}=", val
        end
      end
    end    

    def save
      valid? && topic.save
    end
    
    def topic(klass = Topics::Create::Form)
      @application_form ||= klass.new(subject: decorated_form.subject, text: decorated_form.body_text, user: user, board: board)
    end
    
    def decorated_form(klass = ApplicationFormDecorator)
      @decorated_form ||= klass.decorate self
    end
    
    def structure
      @structure ||= Hash.new { |hash, key| hash[key] = {} }
    end
    
  end
end