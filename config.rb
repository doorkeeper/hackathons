require 'active_support/core_ext/date/calculations'

class Event
  ATTRS = %w{id starts_on date_info title description price address target prize url}
  attr_reader *ATTRS

  def initialize(args)
    ATTRS.each do |s|
      instance_variable_set "@#{s}", args[s]
    end
  end

  def free?; @price == 0; end

end

module EventHelper
  def events
    data.events.map do |k,v|
      Event.new({"id" => k}.merge(v))
    end
  end

  def events_by_month
    events.group_by {|e| e.starts_on.beginning_of_month}.map {|a,b| [a, b.sort_by {|e| e.starts_on}]}.sort_by {|a| a.first}
  end

  def events_for_month(date)
    m = events_by_month.find {|d, events| date == d}
    m && m.last
  end

  def month_path(date)
    "/events/#{date.year}/#{date.month}/"
  end

  def event_path(event)
    "/events/#{event.id}/index.html"
  end
end

extend EventHelper

events_by_month.each do |d, events|
  proxy File.join(month_path(d), "index.html"), "/event_by_date.html", :locals => { date: d }, ignore: true
end

events.each do |event|
  proxy event_path(event), "/event.html", :locals => { event: event }, ignore: true
end

activate :i18n, mount_at_root: :ja

# Methods defined in the helpers block are available in templates
helpers do
  include EventHelper

  def dmy(date)
    "#{date.year}年#{date.month}月"
  end

  def yen(i)
    "#{i}円"
  end

  def md_to_html(plain)
    @markdown ||=
      Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:hard_wrap => true), :autolink => true, :lax_html_blocks => true, tables: true, no_intra_emphasis: true)
    @markdown.render(plain.to_s)
  end

end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

Time.zone = "Tokyo"

activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = true
end
