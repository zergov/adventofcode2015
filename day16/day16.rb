sues_list = {}
File.read('input').lines do |line|
  parts = line.chomp.strip.split(':')
  sue_no = parts.shift.split.last.to_i

  properties = parts.join.split(',').map(&:strip).map(&:split)

  sues_list[sue_no] = properties.each_with_object({}) do |property, h|
    property_name, value = property
    h[property_name] = value.to_i
  end
end

candidates = []
sues_list.each do |sue_no, properties|
  if properties.key?("children") && properties["children"] != 3
    next
  end
  if properties.key?("cats") && properties["cats"] <= 7
    next
  end
  if properties.key?("samoyeds") && properties["samoyeds"] != 2
    next
  end
  if properties.key?("pomeranians") && properties["pomeranians"] >= 3
    next
  end
  if properties.key?("akitas") && properties["akitas"] != 0
    next
  end
  if properties.key?("vizslas") && properties["vizslas"] != 0
    next
  end
  if properties.key?("goldfish") && properties["goldfish"] >= 5
    next
  end
  if properties.key?("trees") && properties["trees"] <= 3
    next
  end
  if properties.key?("cars") && properties["cars"] != 2
    next
  end
  if properties.key?("perfumes") && properties["perfumes"] != 1
    next
  end

  candidates << sue_no
end

p candidates
