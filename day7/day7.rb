require 'set'

def provide_signal(wires, line)
  value, _, wire = line.split(' ').map(&:strip)
  wires[wire] = (value.to_i) % 65536
  true
end

def provide_signal_from_wire(wires, line)
  wire1, _, output = line.split(' ').map(&:strip)
  wires[wire1]
  return unless wires[wire1]
  wires[output] = wires[wire1] % 65536
  true
end

def bitwise_and(wires, line)
  wire1, _, wire2, _, output = line.split(' ').map(&:strip)
  if wire1 =~ /\d/
    return unless wires[2]
    wires[output] = (wire1.to_i & wires[wire2]) % 65536
    true
  else
    return unless wires[wire1] && wires[wire2]
    wires[output] = (wires[wire1] & wires[wire2]) % 65536
    true
  end
end

def bitwise_or(wires, line)
  wire1, _, wire2, _, output = line.split(' ').map(&:strip)
  return unless wires[wire1] && wires[wire2]
  wires[output] = (wires[wire1] | wires[wire2]) % 65536
  true
end

def lshift(wires, line)
  wire1, _, value, _, output = line.split(' ').map(&:strip)
  return unless wires[wire1]
  wires[output] = (wires[wire1] << value.to_i) % 65536
  true
end

def rshift(wires, line)
  wire1, _, value, _, output = line.split(' ').map(&:strip)
  return unless wires[wire1]
  wires[output] = (wires[wire1] >> value.to_i) % 65536
  true
end

def complement(wires, line)
  _, wire1, _, output = line.split(' ').map(&:strip)
  return unless wires[wire1]
  wires[output] = (~wires[wire1]) % 65536
  true
end

wires = {}
visited = Set.new
loop do
  stop = true

  File.read('input').lines do |line|
    line = line.chomp

    if visited.include?(line)
      next
    end

    stop = false
    p "trying out line: #{line}"

    if line.match(/^\d* -> .*$/)
      visited.add(line) if provide_signal(wires, line)
    elsif line.match(/^NOT .* -> .*$/)
      visited.add(line) if complement(wires, line)
    elsif line.match(/^.* AND .* -> .*$/)
      visited.add(line) if bitwise_and(wires, line)
    elsif line.match(/^.* OR .* -> .*$/)
      visited.add(line) if bitwise_or(wires, line)
    elsif line.match(/^.* LSHIFT \d* -> .*$/)
      visited.add(line) if lshift(wires, line)
    elsif line.match(/^.* RSHIFT \d* -> .*$/)
      visited.add(line) if rshift(wires, line)
    elsif line.match(/^.* -> .*$/)
      visited.add(line) if provide_signal_from_wire(wires, line)
    end
  end

  # p wires.sort
  break if stop
end
