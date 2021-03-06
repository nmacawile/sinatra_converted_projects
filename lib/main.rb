require "sinatra"
require "sinatra/reloader" if development?
require_relative "caesar_cipher/caesar_cipher"
require_relative "mastermind/game"

set :root, File.join(File.dirname(__FILE__), '..')
set :views, Proc.new { File.join(root, "views") }

enable :sessions

get '/' do  
  session.clear
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

get '/mastermind' do  
  session.clear
  erb :mastermind
end

post '/mastermind' do
  session[:game] ||= Mastermind::Game.new
  redirect "mastermind" if session[:game].over?
  @code = session[:game].code
  @guesses = session[:game].guesses
  @guess = params[:guess].upcase.split //  
  session[:game].crack_attempt(@guess)
  @over = session[:game].over?
  @message = generate_message(session[:game])
  erb :mastermind
end

def generate_message(game)
  return "Congratulations! You have cracked the code!" if game.code_cracked?
  return "You've run out of turns!" if game.out_of_turns?
end