puts "Задайте основание треугольника"
a = gets.chomp
puts "Задайте высоту треугольника"
h = gets.chomp
s = 0.5 * a.to_i * h.to_i
puts "Площадь треугольника равна #{s}"