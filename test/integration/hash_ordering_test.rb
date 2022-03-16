# frozen_string_literal: true

require 'test_helper'

class HashOrderingTest < Minitest::Test
  module MoneyFilter
    def money(input)
      format(' %d$ ', input)
    end
  end

  module CanadianMoneyFilter
    def money(input)
      format(' %d$ CAD ', input)
    end
  end

  include Liquid5

  def test_global_register_order
    with_global_filter(MoneyFilter, CanadianMoneyFilter) do
      assert_equal(" 1000$ CAD ", Template.parse("{{1000 | money}}").render(nil, nil))
    end
  end
end
