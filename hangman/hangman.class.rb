#Encoding: UTF-8
require 'rubygems'
require 'sqlite3'

class Hangman
	
	def initialize
		@wort       = loadWort
		@gitter     = []
		@buchstaben = []
		
		buchstaben = @wort.split(//u)
		
		buchstaben.each_with_index { |buchstabe,index| 
			@gitter[index] = '_'
			@buchstaben[index] = buchstabe
		}
		#puts @buchstaben
	end
	
	def loadWort
		db = SQLite3::Database.new("woerterliste.db")
		anzahlWorter = db.execute('SELECT count(*) FROM woerter').to_s.to_i
		
		zufallId   = rand(anzahlWorter) + 1
		zufallWort = db.execute('SELECT wort FROM woerter where id = ?', [zufallId]).to_s
		
		return zufallWort.chop
	end

	def user_input()
		print "Dein Buchstabe: "
		buchstabe = gets
		return buchstabe
	end
	
	def draw_fields()
		print "\n"
		@gitter.each_with_index { |char,index| 
			print char
		}
		print "          > "
	end
	
	def check_buchstabe(buchstabe)
		@buchstaben.each_with_index { |char,index| 
			if(char.to_s.downcase == buchstabe.chop.downcase)
				@gitter[index] = char
			end
		}
	end
	
	def start_game()
		self.draw_fields
		loop do
			buchstabe = user_input()
			if(buchstabe.chop == 'help') 
				puts "Immer dieses fuschen! Gesuchte Wort: " + @wort
			else
				check_buchstabe(buchstabe)
			end
			
			draw_fields
			if(@gitter.to_s == @wort)
				puts "Juhuu du hast das Spiel gewonnen!"; break;
			end
		end
	end
end
