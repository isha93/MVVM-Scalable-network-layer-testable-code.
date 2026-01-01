# 🐉 Pokedex: A Masterclass in Bold Atomic Design + MVVM

Welcome to the **Pokedex** project! This repository is designed as a template and learning resource for developers who want to master **Scalable Architecture**, **Modern Networking**, and **Bold Atomic Design** in SwiftUI.

---

## 🏛 The Architecture: MVVM + Service Layer

This project follows a strict separation of concerns to ensure testability and scalability.

### 🧩 Presentation (View & ViewModel)
- **View**: Built using SwiftUI and Atomic Design. It observes the ViewModel and delegates all logic to it.
- **ViewModel**: Uses the `@Observable` macro (iOS 17+). It manages state, handles user intent, and communicates with the Service layer.

### 🛠 Domain & Data (Service Layer)
- **Service (Repository Role)**: Acts as the single source of truth for data. It fetches data from the API via a generic `Networker` and maps it to domain models.
- **Networker**: A reusable, generic networking layer that handles `URLSession`, endpoint construction, and error propagation.

---

## 🧪 The UI Philosophy: Bold Atomic Design

We don't just build views; we build **systems**. Atomic Design breaks the UI down into five distinct levels:

### 1. Atoms (The Smallest Units)
Atoms are the basic building blocks that cannot be broken down further without losing their functionality.
- *Examples*: `TypeBadgeAtom`, `StatBarAtom`, `PokemonNameAtom`, `SkeletonAtom`.

### 2. Molecules (Component Groups)
Molecules are groups of Atoms bonded together to form a simple, functional UI component.
- *Examples*: `StatRowMolecule` (Label + Bar + Value), `PokemonRowMolecule` (Image + Name).

### 3. Organisms (Complex Components)
Organisms are groups of Molecules and Atoms joined together to form a relatively complex, distinct section of an interface.
- *Examples*: `PokemonStatsChartOrganism`, `FeaturedCarouselOrganism`, `PokemonDetailHeaderOrganism`.

### 4. Templates (Layout Structures)
Templates are page-level objects that place components into a layout and articulate the design's underlying content structure.

### 5. Pages
Pages are specific instances of templates that show what a UI looks like with real representative content.

---

## 🎨 Design Tokens: The Source of Truth

To ensure consistency, we use a centralized **Token System**:

| Token Type | File | Description |
| :--- | :--- | :--- |
| **Colors** | `AppColors.swift` | Semantic colors with built-in Dark Mode support and Pokemon type-specific palettes. |
| **Typography** | `Typography.swift` | A `FontToken` system that manages size, weight, line height, and tracking. |
| **Spacing** | `Spacing.swift` | Consistent spacing constants (`xxs` to `xxl`) for layout margins and padding. |

---

## 📡 Networking & Integration

The project integrates with the **PokeAPI v2**.
- **Payload Optimization**: We map specifically to the data we need (Stats, Types, Abilities, Official Artwork).
- **Pagination**: Implemented a robust "Load More" logic in the `PokemonListViewModel`.
- **Robustness**: Advanced error handling with custom `APIRequestError` and `ErrorStateAtom` for UI feedback.

---

## 🧪 Testing Strategy: Given-When-Then

We prioritize the **ViewModel** and **Service** layers for unit testing.
- **Pattern**: Every test follows the `Given-When-Then` structure for clarity.
- **Mocks**: We use `MockNetworker` and `MockService` to test logic in isolation without making real network calls.
- **Edge Cases**: We test for success paths, API failures (404, 500), and state throttling (e.g., preventing duplicate "load more" calls).

---

## 📂 Project Structure

```text
AtomicDesign/
  ├── Styles/               # Design Tokens (Colors, Typography, Spacing)
  ├── Components/           # Atomic Design Elements
  │   ├── Atom/
  │   ├── Molecule/
  │   └── Organism/
  ├── Features/             # Main Feature Modules
  │   ├── PokeList/
  │   └── PokeDetail/
  │       ├── Data/         # API & DTOs
  │       ├── Domain/       # Services
  │       └── Presentation/ # ViewModels & Views
  └── Networking/           # Core Networking Layer
```

---

## 🚀 Learning Goals
1. **Understand Componentization**: See how complex views like `PokemonDetailView` are assembled from smaller, reusable parts.
2. **Master Dependency Injection**: Observe how services are injected into ViewModels to allow for easy mocking.
3. **Handle Async Data**: Learn how to manage loading, success, and error states gracefully in SwiftUI.
4. **Style with Confidence**: Use the token system to change the entire app's look and feel from just a few files.

---

*Project created by Isa Nur Fajar as a template for scalable SwiftUI development.*
