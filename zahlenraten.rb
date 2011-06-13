class ZahlenRatenSpiel
  
  def initialize()
    @zahl = rand(101)
  end
  
  def gibTip(tip)
    if(tip == @zahl)
      puts "Du hast die gesuchte Zahl gefunden"
      result = true
    end

    if(tip < @zahl)
      puts "Die gesuchte Zahl ist größer"
      result = false
    end
      
    if(tip > @zahl)
      puts "Die gesuchte Zahl ist kleiner"
      result = false
    end

    return result
  end
  
end

spiel = ZahlenRatenSpiel.new()
loop do
  puts "Wie ist dein Tip? "
  tip = gets
  if(spiel.gibTip(tip.to_i))
    break
  end
end
    
    