require_relative 'helper'
require_relative 'feedback'

module Mastermind
	class Game
		include Mastermind::Feedback

		private
		
		attr_accessor :code
		
		public
		
		attr_accessor :guesses
		
		def initialize
			@code = create_code
			@guesses = {}.compare_by_identity 
		end
		
		def	create_code
			Array.new(4) { ('A'..'H').to_a.sample }
		end
		
		def crack_attempt(guess)
			guesses[guess] = evaluate(code, guess)			
		end
		
		def code_cracked?
			guesses.values.last == [4, 0]
		end
		
		def out_of_turns?
			guesses.size >= 12
		end
		
	end
end