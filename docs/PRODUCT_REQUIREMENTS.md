# Product Requirements

## Product summary

Gym App is a mobile-first web application for logging gym workouts, tracking progress, and reviewing training history.

The initial audience is a very small set of users, but the architecture should support growth to a standard multi-user product.

## Product philosophy

This is a real product project, not a learning sandbox.
Learning modern Rails full-stack technologies is an important secondary benefit, but product value, coherence, and maintainability take priority.

## MVP goals

1. Secure user accounts with email + password.
2. Shared exercise catalog with rich classification.
3. Workout templates as reusable plans.
4. Real workout sessions with actual performed sets.
5. Plan vs fact workflow.
6. Draft workout session editing during training.
7. Rest timer and last-weight autofill.
8. Simple wellbeing score (1..5) per workout.
9. History calendar.
10. Basic statistics and charts.
11. Admin area.
12. RU/EN localization.

## Core user stories

### Authentication
- As a user, I can register with email and password.
- As a user, I can sign in and sign out securely.
- As a user, I can reset my password safely.

### Exercise catalog
- As a user, I can browse a common exercise catalog.
- As a user, I can filter exercises by muscle group, body part, tags, and equipment.
- As a user, I can view exercise details including image and tags.

### Workout templates
- As a user, I can create a workout template.
- As a user, I can order exercises inside a template.
- As a user, I can start a real workout from a template.

### Real workouts
- As a user, I can create a workout session from a template or from scratch.
- As a user, I can edit sets during the workout.
- As a user, I can record actual weights, reps, and performed sets.
- As a user, I can keep a draft workout and finish it later.
- As a user, I can mark what was completed.
- As a user, I can provide a wellbeing score from 1 to 5.

### Training assistance inside MVP
- As a user, I can see my last used weight for an exercise while logging a set.
- As a user, I can use a rest timer between sets.

### History and stats
- As a user, I can see which days I trained on a calendar.
- As a user, I can see simple charts for progress.
- As a user, I can see best set per exercise.
- As a user, I can see estimated 1RM per exercise.

### Admin
- As an admin, I can manage the shared exercise catalog.
- As an admin, I can manage users.
- As an admin, I can manage tags/classifications/reference data.

## Explicit exclusions from MVP

- AI-based plan generation
- AI-based progress advice
- voice input
- Telegram bot
- social login
- advanced scheduling calendar
- attachments
- offline-first sync

## UX principles

- Must work excellently on a phone browser first.
- Logging a workout must require minimal taps.
- Data entry speed is more important than visual complexity.
- Admin UI can be utilitarian.
- Main user area should feel clean, simple, and calm.

## Engineering principles

- Business use cases should follow one standard project-wide interactor pattern.
- New code must align with established architecture and naming conventions.
- The project should prefer boring, durable solutions over novelty.
- Modern Rails technologies are welcome when they improve the product and developer experience.

## Internationalization

Languages from day one:
- Russian
- English

All visible strings must be localized.

## Future-ready requirements

The system should be designed so future inputs can create workout facts through the same domain services:
- web UI
- Telegram bot
- AI parser
- voice transcript parser

Statistics should be implemented as a separate module so metrics can be added or removed later without rewriting workout logging.
