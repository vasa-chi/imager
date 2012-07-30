require "oily_png"
require "sinatra"

configure do
  mime_type :png, 'image/png'
end

get %r{^/image/(\d+)x(\d+)(x[a-f0-9]{3}[a-f0-9]{3}?)?\.png$} do

  #получаем обязательные размеры изображения
  width, height = params[:captures][0].to_i, params[:captures][1].to_i

  #получаем цвет. Может быть задан в виде #abc или #aabbcc. Если цвет не задан, то выставляется серый.
  color         = params[:captures][2]
  if color.nil?
    color = [128, 128, 128]
  else
    color     = color[1..-1]
    span, mul = color.size == 3 ? [1, 2] : [2, 1]
    color     = color.scan(/.{#{span}}/).map do |c|
      (c*mul).to_i(16)
    end
  end


  png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color.rgb(*color))
  content_type :png
  png.to_blob
end