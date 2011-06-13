
class Mastermind

  def initialize
    @zahl = [rand(5) + 1, rand(5) + 1, rand(5) + 1, rand(5) + 1]
    puts "Starte Mastermind";
    puts "Anleitung:
Suche den Code. Der Code besteht aus 4 Zahlen von 1 - 6.
• => Richtige Zahl an richtiger Stell.
⊗ => Richtige Zahl an falscher Stelle.
Du hast 8 Versuche um den Code zu knacken!
#### <- gesuchter Code!"
  end

  def checkZahl(zahl, stelle)
    if(stelle == 1)
      @prufzahl = @zahl.dup
    end

    if(@zahl[stelle - 1] == zahl)
      return 2
    end

    @prufzahl.each { |z|
      if(zahl == z)
        @prufzahl.delete(z)
        return 1
      end
    }

    return false
  end

  def gibTip(tip)
    stelle = 0
    result = "";
    tip.each_char {|c|
      stelle = stelle + 1
      zahl = c.to_i
      zahlresult = checkZahl(zahl, stelle)
      if(zahlresult && zahlresult > 0)
        if(zahlresult == 2)
          result = result + "•"
        end
        if(zahlresult == 1)
          result = result + "⊗"
        end
      end
    }

    puts "#{tip.chop!} " + result
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
      puts "Leicd ..der verlohren. Richtige Antwort: #{spiel.getZahl}"
    else
      puts "Glückwunsch! Du hast gewonnen!"
    end
    break;
  end
end