require_relative 'helper'
require_relative 'feedback'

module Mastermind
	class Game
		include Mastermind::Feedback

		attr_accessor :code, :guesses
		
		def initialize
			@code = create_code
			@guesses = []
		end
		
		def	create_code
			Array.new(4) { ('A'..'H').to_a.sample }
		end
		
		def crack_attempt(guess)
			guesses.unshift [guess, evaluate(code, guess)]
		end
		
		def code_cracked?
			!guesses.empty? && guesses.first[1] == [4, 0]
		end
		
		def out_of_turns?
			guesses.size >= 12
		end

		def over?
			code_cracked? || out_of_turns?
		end
		
	end
end