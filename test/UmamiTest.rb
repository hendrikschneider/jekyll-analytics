require_relative "../lib/analytics/Umami.rb"
require "test/unit"

class UmamiTest < Test::Unit::TestCase
  def test_default_hosted_tracking_string
    umami = Umami.new({ "website_id" => "94db1cb1-74f4-4a40-ad6c-962362670409" })
    assert_equal(
      '<script defer src="https://cloud.umami.is/script.js" data-website-id="94db1cb1-74f4-4a40-ad6c-962362670409"></script>',
      umami.render()
    )
  end

  def test_self_hosted_source_override
    umami = Umami.new({
      "website_id" => "abc-123",
      "source" => "https://stats.example.com/script.js"
    })
    assert_equal(
      '<script defer src="https://stats.example.com/script.js" data-website-id="abc-123"></script>',
      umami.render()
    )
  end

  def test_optional_attributes_present
    umami = Umami.new({
      "website_id" => "abc-123",
      "host" => "https://data.example.com",
      "domains" => "example.com,www.example.com",
      "auto_track" => false,
      "tag" => "homepage-a",
      "do_not_track" => true,
      "exclude_search" => true,
      "exclude_hash" => true,
      "performance" => true
    })
    assert_equal(
      '<script defer src="https://cloud.umami.is/script.js" data-website-id="abc-123" data-host-url="https://data.example.com" data-domains="example.com,www.example.com" data-auto-track="false" data-tag="homepage-a" data-do-not-track="true" data-exclude-search="true" data-exclude-hash="true" data-performance="true"></script>',
      umami.render()
    )
  end

  def test_optional_attributes_absent
    umami = Umami.new({ "website_id" => "abc-123" })
    rendered = umami.render()
    assert_equal(false, rendered.include?("data-host-url"))
    assert_equal(false, rendered.include?("data-domains"))
    assert_equal(false, rendered.include?("data-tag"))
  end
end
