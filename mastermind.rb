#!/usr/bin/ruby

class Mastermind

  def initialize
    @zahl = [rand(5) + 1, rand(5) + 1, rand(5) + 1, rand(5) + 1]
    @zahl_save = @zahl.dup
    @tip  = [0,0,0,0]

    puts "Starte Mastermind";
    puts "Anleitung:
Suche den Code. Der Code besteht aus 4 Zahlen von 1 - 6.
• => Richtige Zahl an richtiger Stell.
⊗ => Richtige Zahl an falscher Stelle.
Du hast 8 Versuche um den Code zu knacken!
#### <- gesuchter Code!"
  end

  def checkZahlPosition()
    @tip.each_index {|index|
      tipZahl = @tip.at(index).to_i

      if(tipZahl > 0 && tipZahl < 7)
        if(tipZahl == @zahl.at(index))
          @tip[index] = '•'
          @zahl[index] = -1
        end
      end
    }
  end

  def checkZahl()
    @tip.each_index {|index|
       tipZahl = @tip.at(index).to_i

       if(tipZahl > 0 && tipZahl < 7)
        @zahl.each_index { |zahl_index|

          searchZahl = @zahl.at(zahl_index).to_i;
          if(searchZahl > 0 && tipZahl == searchZahl)
            @tip[index] = "⊗"
            @zahl[zahl_index] = -1
          end
        }
        if(@tip.at(index).to_i != 0)
          @tip[index] = ''
        end
       else
         tipChar = @tip.at(index)
        if((tipZahl === 0 || tipZahl > 7) && tipChar != '•')
          @tip[index] = ''
        end
       end
     }
  end

  def checkTip(tip)
    stelle = 0
    result = "";

    if(tip.chop == "help")
      puts "Fuschen? Ich sag dir nicht, dass ich die Zahl #{@zahl_save.to_s} suche!!!"
    end

    tipArray = tip.chop!.split(//)
    tipArray.each_index {|index|
      @tip[index] = tipArray.at(index).to_i
    }

    tipArray = @tip.dup

    checkZahlPosition()
    checkZahl()

    @tip.sort!
    result = @tip.to_s
    puts "#{tipArray.to_s} #{result}"
    @zahl = @zahl_save.dup
    return result
  end

  def getZahl
    @zahl_save.to_s
  end
end

spiel = Mastermind.new()
versuch = 0
loop do
  versuch = versuch + 1
  puts "Dein #{versuch}. Tip:"; tip = gets;
  result = spiel.checkTip(tip)
  if(result == "••••" || versuch > 8)
    if(result == "••••")
      puts "Glückwunsch! Du hast gewonnen!"
    else
      puts "Leider verlohren. Richtige Antwort: #{spiel.getZahl}"
    end
    break;
  end
end
