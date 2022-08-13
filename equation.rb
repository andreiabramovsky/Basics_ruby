puts "Введите коэффициент a"
a = gets.chomp.to_f
puts "Введите коэффициент b"
b = gets.chomp.to_f
puts "Введите коэффициент c"
c = gets.chomp.to_f

d = b ** 2 - 4 * a * c
if d > 0
    x1 = ( - b + Math.sqrt(d) ) / 2 / a
    x2 = ( - b - Math.sqrt(d) ) / 2 / a
    puts "Дискриминант равен #{d}"
    puts "Первый корень равен #{x1}"
    puts "Второй корень равен #{x2}"
elsif d == 0
    x = - b / 2 / a
    puts "Дискриминант равен #{d}"
    puts "Корень равен #{x}"
else
    puts "Дискриминант < 0; корней нет"
end
