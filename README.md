localization_demo - максимально простий демо-проєкт, що локалізує видимий на UI текст у uk та en локалях.
Задача полягає в тому, щоб:
1. Локалізувати текст не використовуючи строкові константи в NSLocalizedString, а за допомогою Enum, що генерується на основі наявних ключів перекладу
2. Мігрувати на рішення з локалізацією через Enum за допомогою скрипта, а не вручну
3. Перевірити, чи містить проєкт ключи локалізації, що не використовуються за допомогою скрипта, а не вручну
4. Перевірити, чи містить проєкт ключи з однаковими перекладами за допомогою скрипта, а не вручну

Вимоги: 
Для запуску скриптів необхідно встановити за потребою сучасну версію Ruby (не старше 3.2.0)

Для запуску демо:
- Змінюємо поточну директорію `cd scripts`
- За потребою, додаємо скрипту `generate_enum.rb` права на виконання `chmod +x generate_enum.rb`
- Запускаємо скрипт `generate_enum.rb` для генерації Enum з кейсами під кожен з ключів локалізації
- За потребою, додаємо скрипту `enumify_lokalizations.rb` права на виконання `chmod +x enumify_lokalizations.rb`
- Запускаємо скрипт `enumify_lokalizations.rb` для заміни NSLocalizedString в коді на використання відповідного кейсу з Enum
- За потребою, додаємо скрипту `check_unused.rb` права на виконання `chmod +x check_unused.rb`
- Запускаємо скрипт `check_unused.rb` для пошуку ключів локалізації, що не задіяні в проєкті
- За потребою, додаємо скрипту `find_duplicates.rb` права на виконання `chmod +x find_duplicates.rb`
- Запускаємо скрипт `find_duplicates.rb` для пошуку ключів локалізації, що мають однакові переклади