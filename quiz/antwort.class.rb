# To change this template, choose Tools | Templates
# and open the template in the editor.

class Antwort
		def initialize(data)
			@antwort, @status = data
		end
		
		def writeAntwort
			puts @antwort
		end
		
		def checkStatus
			return @status == 1
		end
	end
