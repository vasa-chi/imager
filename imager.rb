require "oily_png"
require "sinatra"

configure do
  mime_type :png, 'image/png'
end

get %r{^/image/(\d+)x(\d+)$} do
  png = ChunkyPNG::Image.new(params[:captures][0].to_i, params[:captures][1].to_i, ChunkyPNG::Color.rgb(128, 128, 128))
  content_type :png
  png.to_blob
end