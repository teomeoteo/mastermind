class Player
  def input
    puts "Enter a color"
    puts "(red, green, blue, yellow, purple, orange)"
    print "\n"
    color = ''
    loop do
      color = gets.chomp.to_s.downcase
      if (COLORS.keys.include?(color))
        break
      else
        puts "Invalid color"
      end
    end
    color
  end
end
