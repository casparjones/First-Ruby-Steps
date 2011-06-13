#!/usr/bin/ruby

class Mastermind

  def initialize
    @zahl = [rand(5) + 1, rand(5) + 1, rand(5) + 1, rand(5) + 1]
    puts @zahl
    puts "Starte Mastermind";
    puts "Anleitung:
Suche den Code. Der Code besteht aus 4 Zahlen von 1 - 6.
• => Richtige Zahl an richtiger Stell.
⊗ => Richtige Zahl an falscher Stelle.
Du hast 8 Versuche um den Code zu knacken!
#### <- gesuchter Code!"
  end

  def checkZahlOk(zahl)
    if(@prufzahl == nil)
      @prufzahl = @zahl.dup
    end
    
    puts @prufzahl
    @prufzahl.each_index { |index|
      z = @prufzahl.at(index)
      # puts "prüfen #{z} == #{zahl}"
      if(zahl == z)
        #puts "ok"
        @prufzahl.delete_at(index)
        return 1
      end
    }

    return false
  end

  def checkZahlPositionOk(zahl, stelle)
    if(@prufzahl == nil)
      @prufzahl = @zahl.dup
    end    
    puts "#{zahl} stelle #{stelle} #{@zahl[stelle]} == #{zahl}"
    if(@zahl[stelle] == zahl)
      @prufzahl.delete_at(stelle)
      zahl = 0
      return 2
    end
    return false
  end

  def getZeichen(zahlresult)
    if(zahlresult == 2)
      result = "•"
    end
    if(zahlresult == 1)
      result = "⊗"
    end
    
    return result
  end

  def checkZahl(tip)
    result = ""
    tip.each_char {|c|
      zahl = c.to_i
      if(zahl > 0 && zahl < 7)
        zahlresult = checkZahlOk(zahl)
        if(zahlresult && zahlresult > 0)
          result = result + getZeichen(zahlresult)
        end
      end
    }
    return result
  end

  def checkZahlPosition(tip)
    @tip = tip.split(//)
    result = ""
    stelle = 0
    puts @tip
    @tip.each_index {|index|
      c = @tip.at(index)
      puts "zahl #{c}"
      zahl = c.to_i
      if(zahl>0 && zahl<7)
        zahlresult = checkZahlPositionOk(zahl, stelle)
        if(zahlresult && zahlresult > 0)
          @tip.delete_at(index)
          result = result + getZeichen(zahlresult)
        end
        stelle = stelle + 1
      end
    }
    @tip = @tip.to_s    
    return result
  end

  def gibTip(tip)
    stelle = 0
    result = "";
    result1 = checkZahlPosition(tip)
    puts @prufzahl.to_s
    result2 = checkZahl(@tip)
    puts "tip: #{@tip}"
    result  = result1 + result2
    puts "#{tip.chop!} " + result
    @prufzahl = nil
    return result
  end

  def getZahl
    @zahl.to_s
  end
end

spiel = Mastermind.new()
versuch = 0
loop do
  versuch = versuch + 1
  puts "Dein #{versuch}. Tip:"; tip = gets;
  result = spiel.gibTip(tip)
  if(result == "••••" || versuch > 7)
    if(versuch > 7)
      puts "Leider verlohren. Richtige Antwort: #{spiel.getZahl}"
    else
      puts "Glückwunsch! Du hast gewonnen!"
    end
    break;
  end
end
