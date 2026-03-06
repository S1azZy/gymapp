# Domain Model (High Level)

This file intentionally stays high-level and avoids locking the project into a premature database design.

## Main concepts

### User
Authenticated application user.

Potential responsibilities:
- owns workout templates
- owns workout sessions
- sees personal statistics

### AdminUser or User with admin role
Access to administrative functions.

### Exercise
Shared catalog entry.

Attributes conceptually include:
- name
- description
- image
- body part classification
- muscle group classification
- equipment
- tags
- active flag

### WorkoutTemplate
Reusable plan created by a user.

### WorkoutTemplateExercise
Ordered exercise entry inside a template.

### WorkoutSession
A real training event.

Conceptually includes:
- owner
- date/time
- origin template (optional)
- draft/completed state
- wellbeing score
- notes (optional in future)

### WorkoutSessionExercise
Exercise instance inside a real workout.

Conceptually includes:
- planned source linkage if started from template
- performed flag
- position/order

### SetEntry
Actual performed data for one set.

Conceptually includes:
- reps
- weight
- maybe duration or rest metadata later

### Classification concepts
Shared reference data, likely separate concepts or enums depending on chosen implementation:
- body part
- muscle group
- equipment
- tag

### Statistics module
Consumes workout sessions and set entries to compute:
- best set per exercise
- estimated 1RM
- chart series
- calendar aggregates

## Important modeling principles

1. Template data and actual workout data must stay separate.
2. Actual workout data must remain valid even if template changes later.
3. Shared exercise catalog should be designed so future user-defined extensions are possible.
4. Statistics should read from workout facts, not mutate them.
5. Draft workouts are first-class entities, not temporary UI-only state.
