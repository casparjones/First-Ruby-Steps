# converts decimal to binary: dec2bin(5) => [1,0,1,0]
def dec2bin num, length
  bin = []
  length.times{|i| bin << num[i] }
  bin
end

# draws binary number
def drawbin bin
  width = 20
  flow :width => width, :margin => 20 do
    bin.each_with_index do |b, idx|
      fill rgb(0, 255, 0, 255*b)
      oval :top => idx*width, :left => 0, :radius => width*0.4
    end
  end
end

# draws time in format HH:MM:SS
def draw time
  drawbin dec2bin(time.hour/10, 2)
  drawbin dec2bin(time.hour%10, 4)
  flow :width => 10
  drawbin dec2bin(time.min/10, 3)
  drawbin dec2bin(time.min%10, 4)
  flow :width => 10
  drawbin dec2bin(time.sec/10, 3)
  drawbin dec2bin(time.sec%10, 4)
end

# main application
Shoes.app :width => 180, :height => 120, :title => "Binary Clock", :resizable => false do
  draw Time.now
  every 1 do
    clear do
      draw Time.now
    end
  end
end