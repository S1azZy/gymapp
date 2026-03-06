# Gym App Codex Starter Pack
[![CI](https://github.com/S1azZy/gymapp/actions/workflows/ci.yml/badge.svg)](https://github.com/S1azZy/gymapp/actions/workflows/ci.yml)
![Ruby](https://img.shields.io/badge/Ruby-3.4.x-CC342D?logo=ruby)
![Rails](https://img.shields.io/badge/Rails-8.1.x-D30001?logo=rubyonrails)

Стартовый комплект документов и шаблонов для запуска проекта **Gym App** в Codex.

## Журнал изменений

- [`CHANGES.md`](/Users/a.tselovalnikov/projects/gymapp/CHANGES.md) ведется постоянно.
- После каждого завершенного шага добавляем короткую запись с датой и суммаризацией результата.
- Coverage badge добавляем только когда подключена автоматическая публикация покрытия в CI.

## Что внутри

- `AGENTS.md` — правила для AI-агентов/Codex
- `docs/PRODUCT_REQUIREMENTS.md` — продуктовые требования MVP
- `docs/ARCHITECTURE.md` — архитектурные решения и границы
- `docs/DOMAIN_MODEL.md` — верхнеуровневая доменная модель
- `docs/SECURITY.md` — обязательные security-требования
- `docs/TESTING_STRATEGY.md` — стратегия тестирования и quality gates
- `docs/ROADMAP.md` — этапы MVP → v1.1 → v1.2
- `docs/IMPLEMENTATION_PLAN.md` — практический порядок реализации
- `docs/TECH_DECISIONS.md` — зафиксированные технологические решения и anti-goals
- `config/deploy.yml` — placeholder-конфиг Kamal для будущего деплоя
- `templates/CODEX_BOOTSTRAP_PROMPT.md` — готовый стартовый промпт для Codex
- `templates/` — шаблоны конфигов, которые Codex может положить в репозиторий

## Цель

Создать реальный, пригодный к использованию продукт для трекинга тренировок в фитнес-зале на базе:

- Ruby 4+ (до стабильного Ruby 4: latest stable Ruby 3.4.x)
- Rails 8.1.x (latest stable patch)
- PostgreSQL 18.3 (или latest stable 18.x patch)
- Hotwire (Turbo + Stimulus)
- Tailwind CSS
- Docker / docker-compose
- Kamal
- RSpec

## Приоритеты

1. Продуктовая ценность и удобство использования важнее учебной новизны.
2. Изучение современных Rails-технологий — важная, но вторичная выгода проекта.
3. Security, maintainability, consistency и testability закладываются с первого коммита.
4. Стек и архитектурные решения должны быть современными, но не ради моды, а ради пользы проекту.
5. Проект должен оставаться целостным: единые стили, единая архитектурная дисциплина, единые правила проектирования.

## Архитектурная линия

- Rails monolith
- mobile-first web MVP
- thin models
- use-case/interactor layer в едином стиле через gem `yabi`
- policies для авторизации
- Hotwire/Tailwind для UI
- без SPA-фронтенда в MVP
- без AI в MVP

## Как использовать

1. Создать новый репозиторий.
2. Передать содержимое этих файлов в Codex.
3. Начать с `templates/CODEX_BOOTSTRAP_PROMPT.md`.
4. Попросить Codex сначала создать каркас и инфраструктуру качества.
5. Затем идти по `docs/IMPLEMENTATION_PLAN.md`, сохраняя единый стиль по всему проекту.

## Git workflow

1. Все изменения делаются в отдельной ветке.
2. Для рабочих веток Codex используем префикс `codex/`.
3. Изменения попадают в `main` только через GitHub Pull Request.
4. Перед коммитом и перед обновлением PR локальная проверка должна быть зеленой.

## Make commands

- `make setup` — собрать и поднять проект в Docker.
- `make up` — запустить проект в foreground.
- `make down` — остановить контейнеры.
- `make logs` — смотреть логи web-контейнера.
- `make bash` — открыть shell внутри app-контейнера.
- `make shell` — открыть Rails console.
- `make bundle` — установить gem-зависимости в контейнере.
- `make lint` — запустить RuboCop с autocorrect.
- `make haml-lint` — проверить Haml-шаблоны.
- `make rubocop` — запустить RuboCop с autocorrect.
- `make rubocop-autocorrect` — запустить RuboCop с автокоррекцией.
- `make test` — запустить `RSpec`.
- `make security` — запустить `bundler-audit` и `Brakeman`.
- `make verify-fast` — быстрый локальный gate: lint + Haml + tests.
- `make verify` — полный локальный gate перед коммитом: lint + Haml + tests + security.
- `make ci` — полный CI-пайплайн локально.
- `make doctor` — быстрая проверка локального окружения и версий.
- `make migration NAME=CreateUsers` — создать SQL-only migration skeleton.

## Database rules

- Схема хранится в `structure.sql`.
- Все миграции пишутся только на SQL внутри `up` / `down`.
- Все primary keys должны быть `uuid` с `DEFAULT uuidv7()`.
- `CHECK` используем только для настоящих storage-level invariant, а не для бизнес-валидаций уровня приложения.
- `enum` допустимы; если значениям нужны метаданные и админка, используем отдельные справочники.
- Для моделей с генератором используем `--skip-migration`, затем создаем отдельную SQL-миграцию.

## Views

- Шаблоны проекта пишем на `Haml`, не на `ERB`.

## Быстрый старт

1. `make setup`
2. Открыть [http://localhost:3000](http://localhost:3000)
3. Один раз включить локальный pre-commit hook: `make install-hooks`

После этого каждый `git commit` будет автоматически запускать `make verify`.

Если нужен более быстрый цикл во время активной разработки, используй `make verify-fast`, а перед коммитом оставляй `make verify`.

Дополнительные правила разработки:
- RuboCop запускаем сразу с autocorrect, чтобы не тратить время на механические исправления.
- В `RSpec` используем `shared_context` и `shared_examples`, когда это уменьшает дублирование и не скрывает смысл тестов.
