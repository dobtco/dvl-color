class ClassLoadingSystemSpecController < ApplicationController
  def lib_views
    # nothing here
  end

  def app_models
    # nothing here
  end

  def some_namespace
    render :text => ::SomeNamespace.name
  end

  def some_other_namespace
    render :text => ::SomeNamespace::SomeOtherNamespace.name
  end

  def views_some_namespace
    render :text => ::Views::SomeNamespace.name
  end

  def views_some_other_namespace
    render :text => ::Views::SomeNamespace::SomeOtherNamespace.name
  end

  def autoload_widget
    render :text => Views::AutoloadNamespace::AutoloadWidget.is_here
  end

  def autoload_one_widget_from_another
    # nothing here
  end

  def use_lib_widget_from_view_widget
    # nothing here
  end

  def use_models_widget_from_view_widget
    # nothing here
  end

  def widget_defined_outside_app_views
    require 'views/class_loading_system_spec/widget_defined_outside_app_views'

    # nothing else here
  end

  def underscore_view
    # nothing here
  end

  def underscore_widget_surrounding
    # nothing here
  end

  def foo
    # nothing here
  end

  def bar
    # nothing here
  end

  def require_loaded_underscore_widget_without_views
    require 'class_loading_system_spec/_loaded_underscore_widget'
    render :text => "good!"
  end

  def require_loaded_underscore_widget_with_views
    require 'views/class_loading_system_spec/_loaded_underscore_widget'
    render :text => "good!"
  end

  def render_widget_outside_app_views
    require 'arbitrary_name/some_widget'
    render :widget => ArbitraryName::SomeWidget.new
  end

  def show_module_nesting
    # nothing here
  end
end
