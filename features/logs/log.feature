# language: ru

Функционал: Ведение лога ответов
  Как автор, я хочу просматривать отчет о всех кодах, введенных всеми командами за игру
  А также хочу просматировать отчет о всех кодах, введенных выбранной командой за уровень и за игру

Предыстория:
  Допустим сейчас "2010-07-01 00:00"
  И пользователем Cheburashka создана игра "Приключения покемона"
  И Cheburashka назначает начало игры "Приключения покемона" на "2010-07-02 15:00"
  И Cheburashka добавляет задание "Коробка с апельсинами" с кодом "apelsin" в игру "Приключения покемона"
  И Cheburashka добавляет задание "Апартаменты рептилии" с кодом "croc" в игру "Приключения покемона"
  И Cheburashka добавляет задание "Сбор металлолома" с кодом "metal" в игру "Приключения покемона"
  И зарегистрирована команда "Shapoklyak & Co" под руководством Shapolyak
  И зарегистрирована команда "Crocodiles" под руководством Gena

Сценарий: Автор смотрит лог ответов команды по заданию
  Допустим сейчас "2010-07-02 15:05"
  И команда "Shapoklyak & Co" на задании "Коробка с апельсинами" игры "Приключения покемона" вводит код "мандарин"
  Допустим сейчас "2010-07-02 15:10"
  И команда "Shapoklyak & Co" на задании "Коробка с апельсинами" игры "Приключения покемона" вводит код "ананас"
  Допустим сейчас "2010-07-02 15:15"
  Допустим я логинюсь как Cheburashka
  И захожу в личный кабинет
  И должен увидеть "Приключения покемона"
  И должен увидеть "(статистика)"
  Если я иду по ссылке "(статистика)"
  То должен увидеть "Shapoklyak & Co"
  И должен увидеть "Коробка с апельсинами"
  И должен увидеть "(лог по уровню)"
  Если я иду по ссылке "(лог по уровню)"
  То должен увидеть следующее:
  | Лог ответов           |
  | Shapoklyak & Co       |
  | Коробка с апельсинами |
  | Приключения покемона  |
  | Верный код            |
  | apelsin               |
  | 15:05                 |
  | мандарин              |
  | 15:10                 |
  | ананас                |

Сценарий: Автор смотрит лог ответов команды по уровню в котором один код
  Допустим сейчас "2010-07-02 15:05"
  И команда "Crocodiles" на задании "Коробка с апельсинами" игры "Приключения покемона" вводит код "яблоко"
  Допустим я логинюсь как Cheburashka
  Если я захожу в лог ответов команды "Crocodiles" по игре "Приключения покемона"
  То должен увидеть следующее:
  | Верный код  |
  | apelsin     |

Сценарий: Автор смотрит лог ответов команды по уровню в котором несколько кодов
  Допустим сейчас "2010-07-02 15:05"
  И команда "Crocodiles" на задании "Апартаменты рептилии" игры "Приключения покемона" вводит код "медвед"
  Допустим я логинюсь как Cheburashka
  Если я захожу в лог ответов команды "Crocodiles" по игре "Приключения покемона"
  То должен увидеть следующее:
  | Верные коды |
  | croc        |
  | lizard      |

Сценарий: Автор смотрит статистику команды по игре
  Допустим сейчас "2010-07-02 15:05"
  И команда "Crocodiles" на задании "Коробка с апельсинами" игры "Приключения покемона" вводит код "яблоко"

  Допустим сейчас "2010-07-02 15:10"
  И команда "Crocodiles" на задании "Коробка с апельсинами" игры "Приключения покемона" вводит код "apelsin"

  Допустим сейчас "2010-07-02 15:15"
  И команда "Crocodiles" на задании "Апартаменты рептилии" игры "Приключения покемона" вводит код "croc"

  Допустим сейчас "2010-07-02 15:20"
  И команда "Crocodiles" на задании "Апартаменты рептилии" игры "Приключения покемона" вводит код "lizard"

  Допустим я логинюсь как Cheburashka
  Если я захожу в статистику игры "Приключения покемона"
  То должен увидеть "(лог по игре)"

  Если я иду по ссылке "(лог по игре)"
  То должен увидеть следующее:
  | Лог ответов           |
  | Crocodiles            |
  | Приключения покемона  |
  | Коробка с апельсинами |
  | Верный код            |
  | apelsin               |
  | 15:05                 |
  | яблоко                |
  | 15:10                 |
  | apelsin               |
  | Верные коды           |
  | croc                  |
  | lizard                |
  | 15:15                 |
  | croc                  |
  | 15:20                 |
  | lizard                |

Сценарий: Автор заходит на страницу "Полный лог ответов" через личный кабинет
  Допустим сейчас "2010-07-02 15:05"
  И я логинюсь как Cheburashka
  Если я захожу в личный кабинет
  То должен увидеть следующее:
  | Мои игры             |
  | Приключения покемона |
  | (лог ответов)        |
  Если я иду по ссылке "(лог ответов)"
  То должен увидеть "Полный лог ответов"

Сценарий: Автор заходит на страницу "Полный лог ответов" через "Все игры домена"
  Допустим сейчас "2010-07-02 15:05"
  И я логинюсь как Cheburashka
  Если я иду по ссылке "Все игры домена"
  То должен увидеть следующее:
  | Приключения покемона |
  | (лог ответов)        |
  Если я иду по ссылке "(лог ответов)"
  То должен увидеть "Полный лог ответов"

Сценарий: Автор заходит на страницу "Полный лог ответов" через статистику
    Допустим сейчас "2010-07-02 15:05"
    И я логинюсь как Cheburashka
    Если я захожу в статистику игры "Приключения покемона"
    И должен увидеть "(полный лог ответов)"
    Если я иду по ссылке "(полный лог ответов)"
    То должен увидеть "Полный лог ответов"
@d
Сценарий: Игрок заканчивает игру и получает доступ к полному логу
    Допустим сейчас "2010-07-02 15:05"
    И команда Crocodiles закончила игру "Приключения покемона"
    Если я логинюсь как Gena
    И захожу в личный кабинет
    И иду по ссылке "Посмотреть результаты"
    То должен увидеть следующее:
    | Поздравляем, вы закончили игру! |
    | Лог ответов                     |
    Если я иду по ссылке "Лог ответов"
    То должен увидеть "Полный лог ответов"

