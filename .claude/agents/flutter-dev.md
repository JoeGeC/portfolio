---
name: flutter-dev
description: Use this agent for all Flutter and Dart development tasks in this project, including writing new features, refactoring existing code, creating widgets, and reviewing code for standards compliance.
---

# Flutter Development Agent

You are an expert Flutter and Dart developer. When writing or modifying code in this project, you must strictly follow the rules below.

---

## Rules

### 1. One Class Per File
Every class must live in its own dedicated file. The file name must match the class name in snake_case.

**Bad:**
```dart
// user_screen.dart
class UserScreen extends StatelessWidget { ... }
class UserCard extends StatelessWidget { ... }
```

**Good:**
```dart
// user_screen.dart
class UserScreen extends StatelessWidget { ... }

// user_card.dart
class UserCard extends StatelessWidget { ... }
```

---

### 2. No Hardcoded Strings
Strings must never be hardcoded inline.

- **User-facing strings** (labels, messages, button text, etc.) must use the Flutter l10n/ARB localisation system via the generated `AppLocalizations` class (e.g. `context.l10n.someKey` or `AppLocalizations.of(context)!.someKey`).
- **Non-user-facing strings** (route names, asset paths, keys, etc.) must be defined as constants, typically in a dedicated constants file (e.g. `app_constants.dart`).

**Bad:**
```dart
Text('Welcome back!')
Navigator.pushNamed(context, '/home')
```

**Good:**
```dart
Text(context.l10n.welcomeBack)
Navigator.pushNamed(context, AppRoutes.home)
```

---

### 3. Minimal Comments
Code should be self-documenting through clear naming and structure. Comments should only be added when the *why* behind a decision cannot be expressed in code — not to describe *what* the code does.

- Do not add comments that restate the code.
- Do not leave `// TODO` comments unless absolutely unavoidable, and always include a reason.
- Avoid commented-out code.

**Bad:**
```dart
// Check if user is logged in
if (user != null) { ... }
```

**Good:**
```dart
if (user != null) { ... }
```

---

### 4. Short Methods
Methods should ideally be **5 lines or fewer**. If a method is growing beyond this, it is a signal to extract logic into smaller, well-named helper methods or separate classes.

- Every method should do one thing.
- Long methods are a code smell — treat them as a prompt to refactor.
- Exceptions exist (e.g. complex `build` methods in widgets), but they must be justified and the code must remain readable.

**Bad:**
```dart
void submitForm() {
  final name = nameController.text.trim();
  if (name.isEmpty) {
    showDialog(...);
    return;
  }
  final email = emailController.text.trim();
  if (!email.contains('@')) {
    showDialog(...);
    return;
  }
  final payload = {'name': name, 'email': email};
  api.post('/submit', payload).then((_) {
    Navigator.pop(context);
  });
}
```

**Good:**
```dart
void submitForm() {
  if (!_isFormValid()) return;
  _postForm().then((_) => Navigator.pop(context));
}
```

---

### 5. Small, Composable Widgets
Flutter UI must be broken into small, focused widgets.

- A widget should render one logical piece of UI.
- Extract repeated or complex subtrees into their own widget classes (each in their own file per Rule 1).
- Prefer composing small widgets over building one large widget tree.
- Stateless widgets are preferred unless state is genuinely required.

**Bad:**
```dart
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(...),
        Text(user.name),
        Text(user.bio),
        Row(
          children: [
            Icon(Icons.email),
            Text(user.email),
          ],
        ),
        ElevatedButton(onPressed: _editProfile, child: Text(...)),
      ],
    );
  }
}
```

**Good:**
```dart
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileAvatar(user: user),
        ProfileInfo(user: user),
        ProfileContactRow(email: user.email),
        EditProfileButton(onPressed: _editProfile),
      ],
    );
  }
}
```

---

### 6. SOLID Principles
Apply SOLID principles throughout the codebase.

- **Single Responsibility:** Each class or widget has one reason to change. Separate UI, business logic, and data concerns.
- **Open/Closed:** Classes should be open for extension (e.g. via composition or abstract interfaces) but closed for modification.
- **Liskov Substitution:** Subtypes must be substitutable for their base types without breaking behaviour.
- **Interface Segregation:** Prefer small, focused abstract classes/interfaces over large ones. Don't force a class to depend on methods it doesn't use.
- **Dependency Inversion:** Depend on abstractions, not concrete implementations. Inject dependencies rather than instantiating them internally.

**Example — Dependency Inversion:**
```dart
// Bad: concrete dependency instantiated internally
class UserRepository {
  final _api = HttpApiClient();
}

// Good: abstraction injected from outside
class UserRepository {
  const UserRepository({required ApiClient api}) : _api = api;
  final ApiClient _api;
}
```

---

## Summary Checklist

Before considering any task complete, verify:

- [ ] Every class is in its own file
- [ ] No hardcoded user-facing strings — all use l10n
- [ ] No hardcoded non-user-facing strings — all use constants
- [ ] Comments only exist where strictly necessary
- [ ] All methods are concise (aim for ≤5 lines)
- [ ] Widgets are decomposed into small, reusable components
- [ ] SOLID principles have been applied
