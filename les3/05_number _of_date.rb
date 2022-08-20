#пользовательский ввод

puts "Введите число"
day = gets.chomp.to_i
puts "Введите месяц"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i

#количество дней в месяце
days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

#искомый_номер_даты
desired_date = 0

#первоначальный номер месяца для цикла
months_number = 1

#високосный год
if (year % 4 == 0 && year % 100 != 0) || (year % 100 == 0 && year % 400 == 0)
    days_in_month[2] = 29
end

#цикл. пока введенный пользователем месяц больше months_number, увеличивать искомый номер даты на соответствующее количество дней, заданное в days_in_month = [] и увеличить
#month_number на 1 
while months_number < month do
    desired_date += days_in_month[months_number]
    months_number += 1
end

#увеличить искомую дату на номер дня, который ввел пользователь
desired_date += day

puts "Искомый номер даты - #{desired_date}" 