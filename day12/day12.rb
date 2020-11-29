require 'json'

def crawl(value)
  if value.is_a?(Integer)
    return value
  end

  if value.is_a?(Array)
    return value.sum { |v| crawl(v) }
  end

  if value.is_a?(Hash)
    values = value.values()
    return 0 if value.key?("red") || values.include?("red")
    return crawl(value.values())
  end

  return 0
end

json = JSON.parse(File.read('input').strip)
p crawl(json)
