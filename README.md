## Обновление с репозитория на transifex
С репозитория на transifex автоматически обновляются только файлы с англ. языка (\en), с каждым новым коммитом.

Соответственно в репозитории изменяем только англ. переводы

## Обновление переводов с transifex в репозитории
Остальные переводы обновляем с помощью скрипта script/update_translations.rb

## Настройка скрипта
Переходим в папку script

    cd script
Устанавливаем зависимостм

    bundle install
Копируем secrets.yml.template и вписываем свой username и password c transifex

    cp secrets.yml.template secrets.yml
Запускаем скрипт

    bundle exec ruby update_translations

Комитим и пушим изменения
