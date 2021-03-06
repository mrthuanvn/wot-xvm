﻿Оглавление:
  1. Общая информация
  2. Установка
  3. Обновление
  4. Дополнительная информация по конфигурационному файлу

-----------------------------------------------------------
1. ОБЩАЯ ИНФОРМАЦИЯ
-----------------------------------------------------------

  Этот мод включает в себя следующие возможности:
    * Настраиваемые маркеры над танками
    * Отключение посмертной панели
    * Управление зеркалированием иконок
    * Управление "ушами" (ширина, прозрачность, содержание)
    * Часы на экране загрузки боя
    * Иконки игрока, клана
    * Разные наборы иконок техники как для команд, так и для ушей, экрана загрузки и т.д.
    * Статистика игроков
    * Дополнительная информация в полосе захвата
    * Настраиваемая миникарта
    * Отображение расширенной статистики в окне набора роты и личных достижениях
    * Отображение информации о танке в окне взвода
    * Статус засвета врага в правой боковой панели
    * Автоматическая посадка всего экипажа
    * Отображение пинга серверов до входа на сервер или в бой

  Сайт проекта: http://www.modxvm.com/

  Как написать в поддержку: http://www.koreanrandom.com/forum/topic/1644-readme/
  Поддержка:    http://www.koreanrandom.com/forum/forum/43-xvm/
  FAQ:          http://www.modxvm.com/faq/
  Конфиги:      http://www.koreanrandom.com/forum/forum/50-custom-configurations/
  Редактор:     http://www.koreanrandom.com/forum/topic/1422-/#entry11316

-----------------------------------------------------------
2. УСТАНОВКА
-----------------------------------------------------------

  1. Разархивировать архив в папку с игрой:
     Правой кнопкой на архив -> "Извлечь все..." -> выбрать папку игры -> "Извлечь"

  2. По умолчанию ничего настраивать не надо.

    Если нужны нестандартные настройки, необходимо переименовать загрузочный файл:
      \res_mods\xvm\configs\xvm.xc.sample в xvm.xc
    Инструкции по его настройке находятся внутри.

    Увидеть все возможные настройки можно в папке
      \res_mods\xvm\configs\@Default\
    Или воспользоваться онлайн-редактором: http://www.koreanrandom.com/forum/topic/1422-/#entry11316

    Внимание: если вы меняете конфиг вручную, используйте Блокнот (notepad),
    НЕ используйте word, wordpad и подобные редакторы

  3. Если XVM неправильно определяет язык клиента игры,
    то в конфигурационном файле (по умолчанию \res_mods\xvm\configs\@default\@xvm.xc )
    смените значение переменной "language" с "auto" на код языка.
    Код языка должен совпадать с именем файла в папке \res_mods\xvm\l10n\ (например, "en").

  4. Существует возможность установки ночных сборок XVM.
    Скачать ночные сборки можно на http://wargaming.by-reservation.com/xvm/

-----------------------------------------------------------
3. ОБНОВЛЕНИЕ
-----------------------------------------------------------

  1. Разархивировать архив в папку с игрой:
    Правой кнопкой на архив -> "Извлечь все..." -> выбрать папку игры -> "Извлечь"

  2. Больше НИЧЕГО делать НЕ НАДО.

-----------------------------------------------------------
4. ДОПОЛНИТЕЛЬНАЯ ИНФОРМАЦИЯ ПО КОНФИГУРАЦИОННОМУ ФАЙЛУ
-----------------------------------------------------------

  Конфигурационные файлы мода:
    \res_mods\xvm\configs\@Default\
  Можно скопировать готовый конфиг из папки \res_mods\xvm\configs\user configs\
  Можно создать новый конфиг с помощью онлайн-редактора:
    http://www.koreanrandom.com/forum/topic/1422-/#entry11316

  Все возможные параметры конфига можно посмотреть в конфиге с русскими комментариями,
  который находится в папке документации в архиве мода:
    \res_mods\xvm\configs\@Default\

  Поддерживаемые теги HTML:
    http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText

  Используемые макросы:
    В ушах, на экране загрузки боя и в окне статистики боя по Tab:
      {{nick}}        - ник игрока с названием клана
      {{name}}        - ник игрока без названия клана
      {{clan}}        - клан игрока в квадратных скобках (пусто если нет клана)
      {{clannb}}      - клан игрока без скобок
      {{vehicle}}     - название танка
      {{vehiclename}} - внутреннее название танка (usa-M24_Chaffee)
      {{vtype}}       - типа техники
      {{c:vtype}}     - цвет в зависимости от типа техники
      + макросы статистики (см. ниже)

    В маркерах над танком:
      {{nick}}        - ник игрока с названием клана
      {{name}}        - ник игрока без названия клана
      {{clan}}        - клан игрока в квадратных скобках (пусто если нет клана)
      {{clannb}}      - клан игрока без скобок
      {{squad}}       - значение '1' для своего взвода, пусто для остальных
      {{vehicle}}     - название танка
      {{vehiclename}} - внутреннее название танка (usa-M24_Chaffee)
      {{vtype}}       - типа техники
      {{level}}       - уровень танка арабскими цифрами
      {{rlevel}}      - уровень танка римскими цифрами
      {{turret}}      - маркер сток башни:
                          символ "*" - башня стоковая и в неё нельзя ставить топ орудие
                          символ "'" - башня стоковая и в неё можно ставить топ орудие
                          пусто - башня топовая
      {{hp}}          - текущее здоровье
      {{hp-ratio}}    - процент текущего здоровья (без символа '%')
      {{hp-max}}      - максимальное здоровье
      {{dmg}}         - количество отнятого здоровья
      {{dmg-ratio}}   - процент отнятого здоровья (без символа '%')
      {{dmg-kind}}    - вид урона (атака, пожар, таран и т.д.)
      {{c:hp}}        - цвет в зависимости от текущего здоровья
      {{c:hp-ratio}}  - цвет в зависимости от процента текущего здоровья
      {{c:dmg}}       - цвет в зависимости от источника урона
      {{c:dmg-kind}}  - цвет в зависимости от вида урона
      {{c:vtype}}     - цвет в зависимости от типа техники
      {{c:system}}    - системный цвет (отменяет переопределенный цвет)
      {{a:hp}}        - прозрачность в зависимости от текущего здоровья
      {{a:hp-ratio}}  - прозрачность в зависимости от процента текущего здоровья
      {{l10n:blownUp}}  - перевод текста "Blown-up!", только в "blowupMessage"
      + макросы статистики (см. ниже)

    В логе попаданий (hitlog):
      {{n}}           - общее число попаданий
      {{n-player}}    - число попаданий по каждому игроку
      {{dmg}}         - значение последнего попадания
      {{dmg-total}}   - общая сумма попаданий за бой
      {{dmg-avg}}     - средний урон за время боя
      {{dmg-player}}  - общая сумма попаданий по каждому игроку
      {{dead}}        - признак убийства танка
      {{nick}}        - ник игрока с названием клана
      {{name}}        - ник игрока без названия клана
      {{clan}}        - клан игрока в квадратных скобках (пусто если нет клана)
      {{clannb}}      - клан игрока без скобок
      {{vehicle}}     - название танка
      {{vehiclename}} - внутреннее название танка (usa-M24_Chaffee)
      {{vtype}}       - типа техники
      {{level}}       - уровень танка арабскими цифрами
      {{rlevel}}      - уровень танка римскими цифрами
      {{dmg-kind}}    - вид урона (атака, пожар, таран и т.д.)
      {{c:dmg-kind}}  - цвет в зависимости от вида урона
      {{c:vtype}}     - цвет в зависимости от типа техники
      {{l10n:Hits}}   - перевод текста "Hits"
      {{l10n:Total}}  - перевод текста "Total"
      {{l10n:Last}}   - перевод текста "Last"

    Панель здоровья игроков (hpLeft):
      {{nick}}        - ник игрока с названием клана
      {{name}}        - ник игрока без названия клана
      {{clan}}        - клан игрока в квадратных скобках (пусто если нет клана)
      {{clannb}}      - клан игрока без скобок
      {{vehicle}}     - название танка
      {{vehiclename}} - внутреннее название танка (usa-M24_Chaffee)
      {{vtype}}       - типа техники
      {{level}}       - уровень танка арабскими цифрами
      {{rlevel}}      - уровень танка римскими цифрами
      {{hp}}          - текущее здоровье
      {{hp-ratio}}    - процент текущего здоровья (без символа '%')
      {{hp-max}}      - максимальное здоровье
      {{c:vtype}}     - цвет в зависимости от типа техники
      {{c:hp}}        - цвет в зависимости от текущего здоровья
      {{c:hp-ratio}}  - цвет в зависимости от процента текущего здоровья
      {{l10n:hpLeftTitle}}  - перевод текста "Hitpoints left:", только в "header"

    В полосе захвата:
      {{points}}      - кол-во уже захваченных точек
      {{extra}}       - дополнительная секция текста; показывается только когда захватчики и время вычислены успешно
      {{tanks}}       - кол-во захватчиков; нельзя обсчитать более трёх; может быть помещён только в дополнительную текстовую секцию
      {{time}}        - оставшееся время захвата; минуты и секунды;      может быть помещён только в дополнительную текстовую секцию
      {{time-sec}}    - оставшееся время захвата; только секунды;        может быть помещён только в дополнительную текстовую секцию
      {{speed}}       - скорость захвата; очков в секунду;               может быть помещён только в дополнительную текстовую секцию
      {{l10n:enemyBaseCapture}}     - перевод текста "Base capture by allies!"
      {{l10n:enemyBaseCaptured}}    - перевод текста "Base captured by allies!"
      {{l10n:allyBaseCapture}}      - перевод текста "Base capture by enemies!"
      {{l10n:allyBaseCaptured}}     - перевод текста "Base captured by enemies!"
      {{l10n:Timeleft}}             - перевод текста "Timeleft"
      {{l10n:Capturers}}            - перевод текста "Capturers"

    В миникарте:
      {{level}}       - уровень
      {{short-nick}}  - укороченный ник
      {{vehicle}}     - полное название типа техники
      {{vehicle-class}} - вставка специального символа от класса техники
      {{cellsize}}    - длина стороны ячейки миникарты
      {{vehicle-name}} - возвращает системное название танка - usa-M24_Chaffee
      {{vehiclename}}  - возвращает системное название танка - usa-M24_Chaffee
      {{vehicle-short}}  - короткое название типа техники

    Во взводе:
      {{level}}          - уровень танка арабскими цифрами
      {{rlevel}}         - уровень танка римскими цифрами
      {{vtype}}          - класс танка (текстовая подстановка из конфига)
      {{vtype-l}}        - класс танка (текстовая подстановка из локализации)
      {{battletier-min}} - минимальный уровень боев танка
      {{battletier-max}} - максимальный уровень боев танка

    Макроподстановки статистики (необходимо включить rating/showPlayersStatistics):
      {{avglvl}}      - средний уровень танков игрока
      {{eff}}         - эффективность игрока: http://wot-news.com/index.php/stat/calc/ru/
      {{teff}}, {{e}} - эффективность игрока на текущем танке: http://www.koreanrandom.com/forum/topic/1643-
      {{wn6}}         - рейтинг WN6: http://www.koreanrandom.com/forum/topic/2575-
      {{wn8}}         - рейтинг WN8: http://www.koreanrandom.com/forum/topic/2575-
      {{xeff}}        - эффективность по шкале XVM (00-99, XX для лучших игроков)
      {{xwn6}}         - рейтинг WN6 по шкале XVM (00-99, XX для лучших игроков)
      {{xwn8}}         - рейтинг WN8 по шкале XVM (00-99, XX для лучших игроков)
      {{rating}}      - общий процент побед
      {{battles}}     - количество боев
      {{wins}}        - количество побед
      {{kb}}          - количество кило-боев (округление количества боев до 1000).
      {{t-rating}}    - процент побед на текущем танке
      {{t-battles}}   - количество боев на текущем танке
      {{t-wins}}      - количество побед на текущем танке
      {{t-kb}}        - количество кило-боев на текущем танке
      {{t-hb}}        - количество гекто-боев на танке (гекто = 100)
      {{tdb}}         - средний дамаг за бой для текущего танка - damage/battles
      {{tdv}}         - средняя эффективность дамага для танка - damage/(battles*maxHP)
      {{tfb}}         - среднее количество фрагов за бой для текущего танка
      {{tsb}}         - среднее количество засвеченных врагов за бой для текущего танка
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - динамические цвета для этих макросов
      {{c:eff}}       - цвет в зависимости от эффективности
      {{c:e}}         - цвет в зависимости от эффективности на текущем танке
      {{c:wn6}}       - цвет в зависимости от рейтинга WN6
      {{c:wn8}}       - цвет в зависимости от рейтинга WN8
      {{c:xeff}}      - цвет в зависимости от эффективности по шкале XVM
      {{c:xwn6}}      - цвет в зависимости от рейтинга WN6 по шкале XVM
      {{c:xwn8}}      - цвет в зависимости от рейтинга WN8 по шкале XVM
      {{c:rating}}    - цвет в зависимости от процента побед
      {{c:kb}}        - цвет в зависимости от количества кило-боев
      {{c:avglvl}}    - цвет в зависимости от среднего уровня танков
      {{c:t-rating}}  - цвет в зависимости от процента побед на текущем танке
      {{c:t-battles}} - цвет в зависимости от количества боев на текущем танке
      Любой макрос цвета можно изменить в макрос прозрачности ({{a:tdb}}).

TODO: добавить в остальные readme
      Допускается форматирование текста (используется формат, приближенный к printf):
        {{name[%[flag][width][.prec]type][~suf][|def]}}
        name  - имя макроса
        flag  - "-" для выравнивания влево, иначе выравнивание вправо
                "0" для дополнения чисел ведущими нулями до заданной длины
        width - минимальная ширина
        prec  - максимальная ширина для строк, или количество знаков после запятой для чисел
        type  - тип (s - строка, d - целое число, f - дробное число, ...)
        suf   - суффикс, добавляемый в конце
        def   - значение по умолчанию, которое подставляется при отсутствии значения:
      Например:
        {{name%-10.10s~..}} - обрезать длинные имена до 10 символов, а короткие дополнить
                              до 10 символов и выровнять влево
        {{kb%4.01f~k|----}}   - ширина 4 символа, обязательно 1 символ после запятой, выравнивание вправо
                              если kb==null, будет отображаться "----"
      Подробнее: http://ru.wikipedia.org/wiki/Printf

    Использование макросов перевода - {{l10n:localizationKey}}
      Макросы представляют собой ссылки на перевод в файлах res_mods/xvm/l10n/XX.xc file (XX означает код языка).
      Если перевод не найден, отображается "localizationKey".

      Пример с полосой захвата, используется язык en:
        /l10n/en.xc
          "enemyBaseCaptured": "Base captured by allies!"
        captureBar.xc
          "captureDoneFormat":    "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"

        Как будет отображаться: "<font size='17' color='#FFCC66'>Base captured by allies!</font>"

      Узнать больше о переводах: https://code.google.com/p/wot-xvm/wiki/LocalizingXVM

  Примеры поля "format":
    1. Отобразить количество кило-боев, эффективность и процент побед без изменения цвета:
      "{{kb}} {{xwn8}} {{rating}}"
    2. То же самое, но раскрасить каждое число в зависимости от его значения:
      "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:rating}}'>{{rating}}%</font>"
    3. То же, что и 2, но с выравниванием колонок:
      "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb%2d}}k</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:rating}}'>{{rating%2d}}%</font></font>"
    4. Отобразить процент побед, подкрашенный в зависимости от рейтинга WN8:
      "<font color='{{c:xwn8}}'>{{rating}}</font>"

  Примеры использования динамического цвета и прозрачности:
    "color": "{{c:xwn8}}" - цвет в зависимости от WN8
    "alpha": "{{a:hp}}" - прозрачность в зависимости от количества здоровья

  Иконки кланов и игроков.
  Параметр конфигурационного файла battle/clanIconsFolder определяет путь к корневой
  папке иконок кланов.
  Все иконки загружаются автоматически из подпапки с названием, соответствующем региону
  игры (RU, EU, US, и т.д.).
  Чтобы добавить иконку клана или игрока, просто скопируйте файл иконки в:
    \res_mods\xvm\res\clanicons\[REGION]\clan\ (для клана)
    \res_mods\xvm\res\clanicons\[REGION]\nick\ (для отдельного игрока)
  Так же можно сделать иконку по умолчанию для клана или игрока:
    \res_mods\xvm\res\clanicons\[REGION]\clan\default.png (для клана по умолчанию)
    \res_mods\xvm\res\clanicons\[REGION]\nick\default.png (для игрока по умолчанию)
  Иконки ищутся в следующем порядке:
    nick/<player>.png -> clan/<clan>.png -> clan/default.png -> nick/default.png
  По умолчанию в архив мода добавлены топ 150 кланов.
  Полный архив со всеми кланами можно скачать отдельно:
    http://www.modxvm.com/%d1%81%d0%ba%d0%b0%d1%87%d0%b0%d1%82%d1%8c-xvm/
    Файлы: clanicons-full-ru-XXX.zip (RU), clanicons-full-eu-XXX.zip (EU), clanicons-full-na-XXX.zip (NA),
    clanicons-full-ASIA-XXX.zip (ASIA), clanicons-full-kr-XXX.zip (KR), clanicons-full-vn-XXX.zip (VN)

  Изображение 6-ого чувства.
  Для замены изображения индикатора 6-ого чувства поместите альтернативное изображение PNG формата в
  \res_mods\xvm\res\ с именем SixthSense.png. В комплекте с модом поставляется SixthSense.png.sample, для использования - переименовать.

  Лог попаданий.
  Отрицательные значения x, y позволяют привязать текст к правому и нижнему
  краю, чтобы конфиг работал одинаково на разных разрешениях экрана.

  Часы в бою и на экране загрузки.
  Формат значений: PHP Date: http://php.net/date
  Например:
      "clockFormat": "H:i"          => 01:23
      "clockFormat": "Y.m.d H:i:s"  => 2013.05.20 01:23:45

  Диапазоны эффективности для {{teff}}, {{e}}.
    TEFF       E
    0..299     1 - очень плохой игрок
    300..499   2 - плохой игрок
    500..699   3 - удовлетворительный
    700..899   4 - ниже среднего
    900..1099  5 - средний
    1100..1299 6 - выше среднего
    1300..1549 7 - хороший
    1550..1799 8 - отличный
    1800..1999 9 - мастер
    2000+      E - Эксперт (топ-100 игроков на данной технике)
