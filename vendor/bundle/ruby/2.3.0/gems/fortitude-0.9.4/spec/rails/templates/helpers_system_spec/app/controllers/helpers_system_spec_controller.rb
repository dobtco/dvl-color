class HelpersSystemSpecController < ApplicationController
  # This works around a bug in Rails 3.0.x for image_tag and other asset_tag methods
  config.relative_url_root ||= ""

  def basic_helpers
    # nothing here
  end

  def block_helpers
    # nothing here
  end

  def built_in_outputting_helpers
    # nothing here
  end

  def custom_helpers_basic
    # nothing here
  end

  def custom_helper_outputs
    # nothing here
  end

  def custom_helpers_with_a_block
    # nothing here
  end

  def built_in_outputting_to_returning
    # nothing here
  end

  def built_in_returning_to_outputting
    # nothing here
  end

  def custom_outputting_to_returning
    # nothing here
  end

  def custom_returning_to_outputting
    # nothing here
  end

  def helper_settings_inheritance
    # nothing here
  end

  def decorate(x)
    "*~* #{x} *~*"
  end

  helper_method :decorate

  def controller_helper_method
    # nothing here
  end

  require 'some_stuff'

  helper SomeStuff

  def controller_helper_module
    # nothing here
  end

  def automatic_helpers_disabled
    # nothing here
  end

  def automatic_helpers_inheritance
    # nothing here
  end

  def private_helper_erb
    # nothing here
  end

  def private_helper_fortitude
    # nothing here
  end

  def helpers_that_output_when_refined
    # nothing here
  end
end
