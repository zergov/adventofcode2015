registers = {'a': 1, 'b': 0}
instructions = [l.strip() for l in open('input')]

i = 0
while i < len(instructions):
    instr = instructions[i]

    if "hlf" in instr:
        r = instr.split()[-1]
        registers[r] //= 2
        i += 1

    elif "tpl" in instr:
        r = instr.split()[-1]
        registers[r] *= 3
        i += 1

    elif "inc" in instr:
        r = instr.split()[-1]
        registers[r] += 1
        i += 1

    elif "jmp" in instr:
        i += int(instr.split()[-1])

    elif "jie" in instr:
        parts = instr.split()
        r = parts[1][0]
        offset = int(parts[2])
        if registers[r] % 2 == 0:
            i += offset
        else:
            i += 1

    elif "jio" in instr:
        parts = instr.split()
        r = parts[1][0]
        offset = int(parts[2])
        if registers[r] == 1:
            i += offset
        else:
            i += 1
    else:
        break

print(registers['b'])
