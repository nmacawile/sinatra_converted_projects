require "sinatra"
require "sinatra/reloader"
require_relative "caesar_cipher"

set :root, File.join(File.dirname(__FILE__), '..')
set :views, Proc.new { File.join(root, "views") }

get '/' do
  send_file "views/index.html"
end

get '/caesarcipher' do
  erb :caesarcipher, :locals => { :encrypted => "Type the message you want to decrypt here.", :normal => "Type the message you want to encrypt here.", :key => 3 }
end

post '/caesarcipher' do
  encrypted = params['encrypted']
  normal = params['normal']
  key = params['key'].to_i
  if !normal.nil? && normal != "" then encrypted, normal = caesar_cipher(normal, key), nil
  elsif !encrypted.nil? && encrypted != "" then normal, encrypted = caesar_cipher(encrypted, -1 * key), nil
  else encrypted, normal = ""
  end
  erb :caesarcipher, :locals => { :encrypted => encrypted, :normal => normal, :key => key }
end