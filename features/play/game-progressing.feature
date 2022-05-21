# language: ru

Функционал: Прохождение игры

  Предыстория:
    Допустим есть игра со следующими уровнями:
      | Говны   |
      | Забросы |
      | Финал   |


Правило: Все команды начинают игру с первого уровня

  Сценарий: Все команды начинают игру с первого уровня
    Если я член играющей команды
    То моя команда должна быть на уровне "Говны"

    Если я член другой играющей команды
    То моя команда должна быть на уровне "Говны"


Правило: Игроки одной команды проходят игру вместе

  Сценарий: Игроки одной команды переходят с уровня на уровень вместе
    Допустим я член играющей команды
    И моя команда сейчас на уровне "Говны"
    И я ввожу правильный ответ

    Если я открываю другое окно
    И я другой член той же играющей команды
    То моя команда должна быть на уровне "Забросы"

    Если я ввожу правильный ответ
    И закрываю другое окно
    То моя команда должна быть на уровне "Финал"

  Сценарий: Игроки одной команды завершают игру вместе
    Допустим я член играющей команды
    И я прохожу игру полностью

    Если я открываю другое окно
    И я другой член той же играющей команды
    То моя команда должна закончить игру


Правило: Команды проходят игру независимо друг от друга

  Сценарий: Команды переходят с уровня на уровень независимо друг от друга
    Допустим я член играющей команды
    И моя команда сейчас на уровне "Забросы"

    Если я открываю другое окно
    И я член другой играющей команды
    То моя команда должна быть на уровне "Говны"

    Если я прохожу игру до уровня "Финал"
    И я закрываю другое окно
    То моя команда должна быть на уровне "Забросы"

  Сценарий: Команды заврешают игру независимо друг от друга
    Допустим я член играющей команды
    И я прохожу игру полностью

    Если я открываю другое окно
    И я член другой играющей команды
    То моя команда должна быть на уровне "Говны"
