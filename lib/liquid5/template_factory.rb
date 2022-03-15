# frozen_string_literal: true

module Liquid5
  class TemplateFactory
    def for(_template_name)
      Liquid5::Template.new
    end
  end
end
