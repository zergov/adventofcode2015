def surface_area(l, w, h)
  2*l*w + 2*w*h + 2*h*l
end

def slack(l, w, h)
  [l * w, w * h, h * l].min
end

def ribbon_wrap(l, w, h)
  a, b, _ = [l, w, h].sort
  a * 2 + b * 2
end

def ribbon_bow(l, w, h)
  l * w * h
end

wrapping_paper = 0
ribbon = 0

File.read('input').lines do |l|
  l, w, h =  l.chomp.split('x').map(&:to_i)
  wrapping_paper += surface_area(l, w, h) + slack(l, w, h)
  ribbon += ribbon_wrap(l, w, h) + ribbon_bow(l, w, h)
end

p wrapping_paper
p ribbon
