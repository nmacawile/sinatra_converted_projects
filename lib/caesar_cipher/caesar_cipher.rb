def restrict_to_alphabets(shifted, unshifted)
	if (unshifted.between?(65, 90) && shifted > 90) || (unshifted.between?(97, 122) && shifted > 122) then shifted -= 26
	elsif (unshifted.between?(65, 90) && shifted < 65) || (unshifted.between?(97, 122) && shifted < 97) then shifted += 26
	end
	shifted
end

def caesar_cipher(text, shift = 3)	
	# make sure that shift value doesn't go over 26 or under negative 26
	shift %= 26 if shift.abs > 26	
	text.gsub!(/[a-zA-Z]/) { |char|	restrict_to_alphabets(char.ord + shift, char.ord).chr}
end

#puts caesar_cipher("What a string!", 5)
#   => "Bmfy f xywnsl!"