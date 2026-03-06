# Gym App Codex Starter Pack

Стартовый комплект документов и шаблонов для запуска проекта **Gym App** в Codex.

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
- `CODEX_BOOTSTRAP_PROMPT.md` — готовый стартовый промпт для Codex
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
3. Начать с `CODEX_BOOTSTRAP_PROMPT.md`.
4. Попросить Codex сначала создать каркас и инфраструктуру качества.
5. Затем идти по `docs/IMPLEMENTATION_PLAN.md`, сохраняя единый стиль по всему проекту.
