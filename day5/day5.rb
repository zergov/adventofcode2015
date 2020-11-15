VOWELS = %w(a e i o u)

def nice_string?(string)
  return false if string.include?("ab")
  return false if string.include?("cd")
  return false if string.include?("pq")
  return false if string.include?("xy")

  vowel_count = string.chars.reduce(0) { |n, c| VOWELS.include?(c) ? n + 1 : n }
  return false if vowel_count < 3

  return false unless string =~ /(.)\1{1,}/

  true
end

def nice_string_v2?(string)
  return false unless string =~ /(..).*\1/
  return false unless string =~ /(.).\1/
  true
end

nice_string_count = 0
File.read('input').lines do |line|
  if nice_string_v2?(line.chomp)
    nice_string_count += 1
  end
end

p nice_string_count
