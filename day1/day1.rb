input = File.read('input').chomp.chars

floor = 0
input.each.with_index do |c, i|
  if floor < 0
    p i
    return
  end

  if c == '('
    floor += 1
  elsif c == ')'
    floor -= 1
  end

end

p floor
