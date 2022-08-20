fib = [0, 1]
while fib.last < 89
    fib.push(fib.last + fib[-2])
end
fib.unshift
puts fib