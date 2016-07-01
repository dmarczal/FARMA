require 'version'
require 'expression/expression'

module MathComparison
  class Comparison
    attr_reader :correct_response
    attr_accessor :response

    def initialize(correct_answer, cmas_order, precision)
      @correct_answer = correct_answer
      @options = { cmas_order: cmas_order,
                   precision:  precision}
      @response = nil
    end

    def right_response?()
      if many_answers?
        @correct_response = Expression.eql_with_many_answers?(@correct_answer, @response, @options)
      elsif eql_sinal?
        @correct_response = Expression.eql_with_eql_sinal?(@correct_answer, @response, @options)
      else
        @correct_response = Expression.eql?(@correct_answer, @response, @options)
      end
    end

    def render options = {}
      builder = (options.delete(:builder) || SimpleBuilder).new(self, options)
      builder.render
    end

    private
    def many_answers?
      @correct_answer.to_s.include?(';')
    end

    def eql_sinal?
      @correct_answer.to_s.include?('=')
    end
  end

  class Builder
    include ActionView::Context
    include ActionView::Helpers::TagHelper

    attr_accessor :output_buffer

    def initialize element, options
      @element = element
      @options  = options
    end

    def render
      raise NotImplementedError
    end
  end

  class SimpleBuilder < Builder
    
    def render
      valid = @element.correct_response ? 'valid' : 'invalid'

      content_tag :div, class: 'col s12 row' do
        if @element.response == nil
          content_tag :div, class: 'box-response center' do
            '<span>Testar Resposta</span>'.html_safe
          end
        else
          content_tag :div, class: "box-response center #{valid}" do
            "<span>#{@element.response}</span>".html_safe
          end
        end
      end.concat modal_response.html_safe
    end

    def modal_response
      content_tag :form, class: 'col s12', action: @options[:action], method: 'POST', 'data-remote' => 'true' do
        content_tag :div, class: 'row' do
          input_field = content_tag :div, class: 'input-field col s6' do
                          input = "<input id=\"#{@options[:id]}\" type=\"text\" value=\"#{@element.response}\" name=\"response\">".html_safe
                          label = content_tag :label, for: @options[:id] do
                                    "Testar Resposta"
                                  end
                          input + label
                        end

          button = content_tag :button, type: 'submit', class: 'btn' do
                     'Testar'
                   end

          input_field + button
        end
      end
    end
  end
end
