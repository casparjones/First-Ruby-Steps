require 'rubygems'
require 'faster_csv'
require 'sqlite3'

db = SQLite3::Database.new("quiz-fragen.db")
db.execute('create table frage (id INTEGER PRIMARY KEY, frage CHAR(120), kategorie CHAR(120), level INTEGER)')
db.execute('create table antwort (id INTEGER PRIMARY KEY, frage_id INTEGER, antwort CHAR(255), status INTEGER)')

count  = 0
countA = 0
FasterCSV.foreach("quiz-fragen.csv", :quote_char => '"', :col_sep =>';', :row_sep =>:auto) do |row|
	if(count > 0)
=begin
			0 Frage
			1 richtige Antwort
			2 Antwort2
			3 Antwort3
			4 Antwort4
			5 Vorkommentar
			6 Nachkommentar
			7 Bildurl
			8 Thema
			9 Schwierigkeitsstufe
=end
		insertQ   = 'INSERT INTO frage (id, frage, kategorie, level) VALUES (?, ?, ?, ?)'
		insertQV  = [count, row[0], row[8], row[9]]
		db.execute(insertQ, insertQV)
		
		insertA   = 'INSERT INTO antwort (id, frage_id, antwort, status) VALUES (?, ?, ?, ?)'

		countA = countA + 1
		insertAV1 = [countA, count, row[1], 1]
		db.execute(insertA, insertAV1)

		countA = countA + 1
		insertAV2 = [countA, count, row[2], 0]
		db.execute(insertA, insertAV2)

		countA = countA + 1
		insertAV3 = [countA, count, row[3], 0]
		db.execute(insertA, insertAV3)
		
		countA = countA + 1
		insertAV4 = [countA, count, row[4], 0]
		db.execute(insertA, insertAV4)
		puts count
	end
	count = count + 1
end
