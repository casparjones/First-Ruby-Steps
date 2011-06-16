require 'rubygems'
require 'sqlite3'

class Frage
		def initialize()
			@antworten = []
		end
		
		def loadLevel(level)
			idNr = rand(30) + 1
			db = SQLite3::Database.new("quiz-fragen.db")
			@id,@frage,@kategorie,@level = db.execute("SELECT * from frage WHERE id > ? AND level = ? LIMIT 1", [idNr, level]).shift
			
			initAntworten()
		end
		
		def initAntworten()
			db = SQLite3::Database.new("quiz-fragen.db")
			antworten  = db.execute("SELECT antwort,status from antwort WHERE frage_id = ?", [@id])
			antworten.each_with_index { |antwort, index|
				@antworten[index] = Antwort.new(antwort)
			}
			@antworten.shuffle!
		end
		
		def schreibeFrage
			puts @frage
		end
		
		def writeAntworten
			@antworten.each_with_index{ |antwort, index|
				print (index + 1).to_s + ') '
				antwort.writeAntwort
			}
		end
		
		def checkAntwort(antwortId)
			antwortIndex = antwortId - 1
			antwort = @antworten[antwortIndex]
			return antwort.checkStatus
		end
	end
