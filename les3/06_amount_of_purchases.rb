#итоговая сумма покупки
total = 0

#итоговый хэш
basket = {}


#в цикле запрашивать ввод наименования товара, его стоимости и его количества
#заполнять basket{} вложенным {product} c парой ключ-значение (price => amount)

#basket ====> {product} =====> {price, amount}
loop do
    puts "Введите название товара. Чтобы закончить выбор введите stop"
    product = gets.chomp.to_s
    break if product == "stop"
    puts "Введите стоимость товара"
    price = gets.chomp.to_i
    puts "Введите количество товара"
    amount = gets.chomp.to_i
    basket[product] = {price => amount}
end

#перебрать циклом все product в basket по названию и цене
basket.each do |product, price|
    #перебрать все в цене по цене(a) и количеству(b)
    price.each do |a, b|
        #итоговая стоимость одного товара
        product_total = a * b

    puts "Товар: #{product} Цена за единицу: #{a} Стоимость товара: #{b}"

#итоговая сумма покупки
    total += product_total
    end
end

puts "Итоговая сумма покупок: #{total}"
