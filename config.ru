require 'rack/rewrite'
use Rack::Rewrite do
  r301 %r{.*}, 'https://www.doorkeeper.jp/%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88/%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3'
end

# Serve a 404 page if all else fails
run lambda { |env|
  [
    404,
    {
      "Content-Type"  => "text/html",
      "Cache-Control" => "public, max-age=60"
    },
    ["File not found!"]
  ]
}
