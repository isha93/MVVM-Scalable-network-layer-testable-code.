# 🐉 Pokedex: A Simple Guide to Atomic Design + MVVM

Welcome to the **Pokedex** project! This project is a simple example for developers who want to learn how to build apps that are easy to grow and maintain using SwiftUI.

---

## 🏛 How the App is Built: MVVM + Service Layer

We split the code into different parts so it is easy to test and change later.

### 🧩 The UI Part (View & ViewModel)
- **View**: This is what the user sees. It uses SwiftUI and Atomic Design. It does not have logic; it just shows what the ViewModel tells it to.
- **ViewModel**: This part holds the logic. It gets data from the Service and prepares it for the View.

### 🛠 The Data Part (Service Layer)
- **Service**: This is the "Data Helper". It gets information from the internet and turns it into things the app can understand.
- **Networker**: A simple tool that talks to the internet.

---

## 🧪 UI Design: Atomic Design

In this app, we don't just build big screens. We build **small parts** that fit together. We use an idea called "Atomic Design."

### Why use Atomic Design?

1.  **Easy to Grow**: We build small parts first. Then we use them to build big parts. This means we don't have to write the same code twice.
2.  **Looks the Same**: Since we use the same small parts everywhere (like buttons and labels), the app looks clean and consistent.
3.  **Fast to Change**: If you want to change how a button looks, you only change it in one place. The whole app updates automatically.
4.  **Easy to Talk**: It helps developers and designers talk using the same names for parts.

---

### The 5 Levels of Atomic Design

#### 1. Atoms (The Basic Parts)
Atoms are the smallest pieces. You cannot break them down more. They are like the "building blocks."
- **What they are**: Colors, fonts, or small things like a name label or a simple bar.
- **Files**: `TypeBadgeAtom.swift`, `StatBarAtom.swift`, `PokemonNameAtom.swift`.

#### 2. Molecules (Small Groups)
Molecules are a few Atoms put together to do one simple job.
- **Example**: A "Stat Row" which is just a label atom + a bar atom put together.
- **Files**: `StatRowMolecule.swift`.

#### 3. Organisms (Complex Parts)
Organisms are bigger parts made of Molecules and Atoms. They form a clear section of the screen.
- **Example**: A "Stats Chart" that shows all the stats of a Pokemon.
- **Files**: `PokemonStatsChartOrganism.swift`.

#### 4. Templates (The Layout)
Templates are like a "skeleton" or a "blueprint." They show where the parts go on the screen, but they don't have real data yet.
- **Job**: They define how the page is laid out.

#### 5. Pages
Pages are the final screens. This is where we put real Pokemon data into the templates.

---

## 🎨 Design Tokens (Basic Styles)

To make sure the app always looks the same, we keep our styles in one place:

| Style Type | File | What it does |
| :--- | :--- | :--- |
| **Colors** | `AppColors.swift` | Holds all the colors for the app and different Pokemon types. |
| **Fonts** | `Typography.swift` | Holds all the text sizes and styles. |
| **Spacing** | `Spacing.swift` | Holds the standard gaps and padding between parts. |

---

## 📡 Internet and Data

The app gets information from the **PokeAPI**.
- **Clean Data**: We only take the data we actually need (like stats and images).
- **Infinite Scroll**: The app can load more Pokemon as you scroll down.
- **Error Handling**: If the internet is down, the app shows a simple message and a retry button.

---

## 🧪 Testing

We write tests to make sure the "Logic" and "Data" parts work correctly.
- **The Pattern**: We use a simple "Given-When-Then" way to write tests so they are easy to read.
- **Mocks**: we use "Fake Data" for tests so we don't need the actual internet to test the app.

---

## 🚀 What You Can Learn
1. **How to Break Down UI**: See how a big screen is made of small parts.
2. **How to Swap Parts**: Learn how to use fake data for testing.
3. **How to Handle Internet Data**: See how to show loading and error messages.
4. **How to Style Easily**: Change the look of the whole app in just one file.

---

*Project created by Isa Nur Fajar to show how to build clean SwiftUI apps.*
