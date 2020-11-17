def next_password(password)
  password = password.reverse
  incr = true

  new_password = password.chars.map do |c|
    next c unless incr

    next_char = (c.ord + 1).chr

    if next_char > "z"
      incr = true
      "a"
    else
      incr = false
      next_char
    end
  end

  new_password.join.reverse
end

INCREASING_STRAIGHTS = []
for c in "a".."x"
  INCREASING_STRAIGHTS << "#{c}#{(c.ord + 1).chr}#{(c.ord + 2).chr}"
end

def valid_password?(password)
  return false unless INCREASING_STRAIGHTS.any? { |straight| password.include?(straight) }
  return false if password =~ /i|o|l/

  first_pair = password.match(/(.)\1/)&.captures&.first
  return false unless first_pair

  second_pair = password.match(/([^#{Regexp.escape(first_pair)}])\1/)&.captures&.first
  return false unless second_pair

  true
end

# password = next_password("hxbxwxba") # <-- this is part 1
password = next_password("hxbxxyzz")
loop do
  if valid_password?(password)
    p password
    break
  else
    password = next_password(password)
  end
end
