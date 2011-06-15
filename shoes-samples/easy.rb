Shoes.app do
  stack do
    @txt = edit_box "Hey", :width => 200, :height => 100 do
      @p.fraction = @txt.text.length / 200.0
    end
    button "OK" do
      @txt.remove
    end
    @p = progress :width => 200
    @l = list_box :items => ["YES", "NO"] do
      alert @l.text
    end
  end
end
