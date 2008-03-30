require 'test/unit'
require 'rubygems'
require 'action_controller'
require 'action_controller/test_process'
require 'fileutils'
require File.expand_path(File.dirname(__FILE__) + "/../lib/labeled_form_with_errors_helper")
require File.expand_path(File.dirname(__FILE__) + "/../init")


# create some routes

# create a dummy controller

class LabeledFormWithErrorsHelperTest < Test::Unit::TestCase
  include ActionView::Helpers::FormTagHelper
  include LabeledFormWithErrorsHelper
  
  def test_proc
    ar_proc = ActionView::Base.field_error_proc
    assert_equal("<span class=\"form_error\">input_or_label_tag</span>", ar_proc.call('input_or_label_tag'))
  end
  
private
  def write_sample(filename, content)
    FileUtils.mkdir_p "test/output"
    File.open("test/output/#{filename}", 'w') do |f|
      f.write %(<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html><head></head><body>)
      f.write content
      f.write %(</body></html>)
    end
  end
end

