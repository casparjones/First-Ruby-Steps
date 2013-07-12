require "./frage.class.rb"
require "./antwort.class.rb"

class Quiz
		def initialize
			@fragen = []
			
			(1..5).each{ |level|
				if(level != nil) 
					@fragen[level] = Frage.new()
					@fragen[level].loadLevel(level)
				end
			}
		end
		
		def start
			(1..5).each{ |level|
				frage = @fragen[level]
				#puts frage.inspect
				frage.schreibeFrage
				frage.writeAntworten
				print "Deine Auswahl: "
				userAntwort = gets
				if(frage.checkAntwort(userAntwort.to_i))
					puts "Richtig!"
				else
					puts "Falsch, leider Verlohren!"
					exit
				end
			}
			puts "Du hast alle Fragen richtig beantwortet. Du bist Quizkoenig!"
		end
	end
