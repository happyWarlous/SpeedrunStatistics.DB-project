База данных по статистике спидранов по играм. Сущности будут иметь вид:

- Игра
    - Название
    - Жанр
    - Год выпуска
    - Платформа

- Категория(!)
    - Название
    - Нынешний лидер

- Спидран
    - Игрок
    - Время прохождения
    - Дата забега
    - Ссылка на подтверждение

- Подробная информация о спидране(!!)
    - Платформа игры
    - Модификации, при наличии
    - Версия игры

- Игорк(подробная информация о нём)
    - Ник
    - Имя
    - Страна
    - Ссылки на соц. сети

(!) - Спидраны разделяют на отдельные категории, в который игрок проходит игру. Как пример самая популярная категория, которая встречается почти во всех играх, any% заключается в том, чтобы пройти игру (увидеть финальные титры) за наименьшее возможное время

(!!) - Я подумал, что эту информацию стоит вынести в отдельную сущность

_Проект делался на GitLab'е_
