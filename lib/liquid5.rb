# frozen_string_literal: true

# Copyright (c) 2005 Tobias Luetke
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Liquid5
  FilterSeparator             = /\|/
  ArgumentSeparator           = ','
  FilterArgumentSeparator     = ':'
  VariableAttributeSeparator  = '.'
  WhitespaceControl           = '-'
  TagStart                    = /\{\%/
  TagEnd                      = /\%\}/
  VariableSignature           = /\(?[\w\-\.\[\]]\)?/
  VariableSegment             = /[\w\-]/
  VariableStart               = /\{\{/
  VariableEnd                 = /\}\}/
  VariableIncompleteEnd       = /\}\}?/
  QuotedString                = /"[^"]*"|'[^']*'/
  QuotedFragment              = /#{QuotedString}|(?:[^\s,\|'"]|#{QuotedString})+/o
  TagAttributes               = /(\w[\w-]*)\s*\:\s*(#{QuotedFragment})/o
  AnyStartingTag              = /#{TagStart}|#{VariableStart}/o
  PartialTemplateParser       = /#{TagStart}.*?#{TagEnd}|#{VariableStart}.*?#{VariableIncompleteEnd}/om
  TemplateParser              = /(#{PartialTemplateParser}|#{AnyStartingTag})/om
  VariableParser              = /\[[^\]]+\]|#{VariableSegment}+\??/o

  RAISE_EXCEPTION_LAMBDA = ->(_e) { raise }

  singleton_class.send(:attr_accessor, :cache_classes)
  self.cache_classes = true
end

require "liquid5/version"
require 'liquid5/parse_tree_visitor'
require 'liquid5/lexer'
require 'liquid5/parser'
require 'liquid5/i18n'
require 'liquid5/drop'
require 'liquid5/tablerowloop_drop'
require 'liquid5/forloop_drop'
require 'liquid5/extensions'
require 'liquid5/errors'
require 'liquid5/interrupts'
require 'liquid5/strainer_template'
require 'liquid5/strainer_factory'
require 'liquid5/expression'
require 'liquid5/context'
require 'liquid5/parser_switching'
require 'liquid5/tag'
require 'liquid5/tag/disabler'
require 'liquid5/tag/disableable'
require 'liquid5/block'
require 'liquid5/block_body'
require 'liquid5/document'
require 'liquid5/variable'
require 'liquid5/variable_lookup'
require 'liquid5/range_lookup'
require 'liquid5/file_system'
require 'liquid5/resource_limits'
require 'liquid5/template'
require 'liquid5/standardfilters'
require 'liquid5/condition'
require 'liquid5/utils'
require 'liquid5/tokenizer'
require 'liquid5/parse_context'
require 'liquid5/partial_cache'
require 'liquid5/usage'
require 'liquid5/register'
require 'liquid5/static_registers'
require 'liquid5/template_factory'

# Load all the tags of the standard library
#
Dir["#{__dir__}/liquid5/tags/*.rb"].each { |f| require f }
