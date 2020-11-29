import re

chars_str_code = 0
chars_mem = 0
escaped_str_code = 0

for line in open('input'):
    line = line.strip()

    chars_str_code += len(line)
    chars_mem += len(eval(line))
    escaped_str_code += len(line.replace('\\', '\\\\').replace('"', '\\"')) + 2 # wrapping 2 "

print(chars_str_code - chars_mem)
print(escaped_str_code - chars_str_code)
