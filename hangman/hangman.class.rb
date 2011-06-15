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
	
	def drawHangman(deadStatus) 
		case deadStatus.to_i
		when 0 then
			puts '_____   '
			puts '|   |   '
			puts '|   0   '
			puts '|  /|\  '
			puts '|  / \  '
			puts '|       '
			puts '|\      '
		when 1 then
			puts '_____   '
			puts '|   |   '
			puts '|   0   '
			puts '|  /|\  '
			puts '|       '
			puts '|       '
			puts '|\      '
		when 2 then
			puts '_____   '
			puts '|   |   '
			puts '|   0   '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|\      '
		when 3 then
			puts '_____   '
			puts '|   |   '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|\      '
		when 4 then
			puts '_____   '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|\      '
		when 5 then
			puts '        '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|       '
			puts '|\      '
		when 6 then
			puts '        '
			puts '        '
			puts '        '
			puts '        '
			puts '        '
			puts '|       '
			puts '|\      '
		end

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
		found = false
		@buchstaben.each_with_index { |char,index| 
			if(char.to_s.downcase == buchstabe.chop.downcase)
				@gitter[index] = char
				found = true
			end
		}
		return found
	end
	
	def start_game()
		leben = 7
		self.draw_fields
		loop do
			buchstabe = user_input()
			if(buchstabe.chop == 'help') 
				puts "Immer dieses fuschen! Gesuchte Wort: " + @wort
			else
				found = check_buchstabe(buchstabe)
				if(found == false)
					leben = leben - 1
					drawHangman(leben)
					if(leben == 0)
						puts "Du bist leider tot -.- Das Gesuchte Wort war '#{@wort}'"; break;
					end
				end
			end
			
			draw_fields
			if(@gitter.to_s == @wort)
				puts "Juhuu du hast das Spiel gewonnen!"; break;
			end
		end
	end
end
