require 'test_helper'

class MountainViewTest < ActionDispatch::IntegrationTest
  teardown { clean_sprockets_cache }

  test "engine is loaded" do
    assert_equal ::Rails::Engine, MountainView::Engine.superclass
  end

  test "stylesheets are properly served" do
    get "/assets/mountain_view.css"

    assert_response :success
    assert_match(/\.header {/, response.body)
    refute_match(/FileNotFound/, response.body)
  end

  test "javascripts are properly served" do
    get "/assets/mountain_view.js"

    assert_response :success
    assert_match(/console\.log\("header"\)/, response.body)
    refute_match(/FileNotFound/, response.body)
  end

  test "shows styleguide" do
    get "/mountain_view"

    assert_response :success
    assert_match(/Select one of the components from the side to view its examples and documentation/, response.body)
  end

  test "shows specific component" do
    get "/mountain_view/styleguide/header"

    assert_response :success
    assert_match(/Header/, response.body)
    assert_match(/20 Mountains you didn.+t know they even existed/, response.body)
  end

  private

  def clean_sprockets_cache
    FileUtils.rm_rf File.expand_path("../dummy/tmp",  __FILE__)
  end
end
