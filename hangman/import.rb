require 'rubygems'
require 'sqlite3'

db = SQLite3::Database.new("woerterliste.db")
db.execute('create table woerter (id INTEGER PRIMARY KEY, wort CHAR(120))')

data = File.readlines("woerterliste.txt")
data.each_with_index { |line,index| 
	db.query('INSERT INTO woerter (id, wort) VALUES (?, ?)', [index, line])
	puts line
}
