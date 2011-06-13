class ModText
  
  def initialize(txt  = "")
    @txt = txt
  end
  
  def get_text
    @txt
  end
  
  def rot13
    @txt.tr("[A-Z][a-z]", "[N-ZA-M][m-za-m]")
  end
  
end

mtext = ModText.new("Hallo, meine liebe Welt!")
puts "Orginal:     #{mtext.get_text}"
puts "Caesar Code: #{mtext.rot13}"

