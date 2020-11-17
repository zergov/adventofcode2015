ingredients = []

File.read('input').lines do |line|
  line = line.chomp

  ingredient, properties = line.split(':')
  properties = properties.strip.split(',')

  ingredients << {
    capacity: properties[0].split.last.to_i,
    durability: properties[1].split.last.to_i,
    flavor: properties[2].split.last.to_i,
    texture: properties[3].split.last.to_i,
    calories: properties[4].split.last.to_i,
  }
end

scores = []
for i in 0..100
  for j in 0..(100-i)
    for k in 0..(100-i-j)
      h = 100-i-j-k

      capacity = ingredients[0][:capacity] * i + ingredients[1][:capacity] * j + ingredients[2][:capacity] * k + ingredients[3][:capacity] * h
      durability = ingredients[0][:durability] * i + ingredients[1][:durability] * j + ingredients[2][:durability] * k + ingredients[3][:durability] * h
      flavor = ingredients[0][:flavor] * i + ingredients[1][:flavor] * j + ingredients[2][:flavor] * k + ingredients[3][:flavor] * h
      texture = ingredients[0][:texture] * i + ingredients[1][:texture] * j + ingredients[2][:texture] * k + ingredients[3][:texture] * h
      calories = ingredients[0][:calories] * i + ingredients[1][:calories] * j + ingredients[2][:calories] * k + ingredients[3][:calories] * h

      next unless calories == 500

      if (capacity < 0 || durability < 0 || flavor < 0 || texture < 0)
        scores << 0
      else
        scores << (capacity * durability * flavor * texture)
      end
    end
  end
end

p scores.max
