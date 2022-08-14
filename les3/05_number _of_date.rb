puts "Введите количество дней: "
days = gets.chomp.to_i
puts "Введите количество месяцев: "
months = gets.chomp.to_i
puts "Введите год: "
years = gets.chomp.to_i


in_february = 28
if (years % 4 == 0) & (years % 100 != 0) or (years % 400 == 0)
    in_february += 1
end

days_in_month = [31, in_february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]


res = days
for month in (0..months-1)
    res += days_in_month[month]
end


puts "\nОтвет #{res}."
