puts "Как Вас зовут?"
name = gets.chomp
puts "Какой у Вас рост (в см)?"
height = gets.chomp
weight = (height.to_i - 110) * 1.15
if weight < 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш идеальный вес #{weight}"
end