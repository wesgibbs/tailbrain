require 'sinatra'
require 'sinatra/json'
require 'meme_generator'

get '/', :provides => :html do
  haml :index
end

get '/generate', :provides => :html do
  image_path = generate_image
  @image_url = url(image_path[/\/tmp\/(meme-\d+.jpeg)/i, 1])
  haml :generate
end

get '/generate', :provides => :json do
  image_path = generate_image
  json image: url(image_path[/\/tmp\/(meme-\d+.jpeg)/i, 1])
end

private

def generate_image
  image_path = MemeGenerator.generate('tailbrain.png', params[:text], 'blame it on the tailbrain')
  FileUtils.mv(image_path, "./public/")
  image_path
end
