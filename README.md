# MVVM Scalable Network Layer — Testable iOS Architecture

A lightweight and scalable iOS architecture using **MVVM + independent Network Layer**, focused on **unit-testability, modularity, and reusability**.

Repository ini menunjukkan bagaimana memisahkan concerns:
- View/UI (SwiftUI / UIKit)
- ViewModel (logic, state, transformation)
- Network Layer (API abstraction, protocol-based)
- Entities / Models (decoupled & mockable)

---

## 🚀 Goals of This Architecture
- **Reduce coupling** — Module tidak saling tahu implementation detail.
- **Easily Mockable** — Semua API call bisa ditest tanpa network.
- **Composable & Maintainable** — Mudah scale ketika API tambah kompleks.
- **Less boilerplate** untuk projek kecil, tapi tetap bisa tumbuh untuk projek besar.

---

## 🧱 Architecture Overview

```
Presentation Layer (SwiftUI / UIKit Views)
                 ↓
         ViewModel (ObservableObject)
                 ↓
        Repository / Data Source
                 ↓
    Network Layer (URLSession abstraction)
                 ↓
             API Provider
```

Core concept:
- ViewModel **tidak tahu** bagaimana API bekerja — hanya menerima abstraction.
- NetworkService menggunakan **protocol** sehingga bisa di-mock.
- Bisa swap real API ↔ mock API tanpa ubah UI/ViewModel.

---

## 📂 Folder Structure

```
MVVM-Scalable-Network/
│
├── Models/
├── ViewModels/
├── Views/
│
├── Networking/
│   ├── NetworkService.swift
│   ├── Endpoints.swift
│   ├── HTTPMethod.swift
│   ├── NetworkError.swift
│   └── Mock/
│       └── MockNetworkService.swift
│
└── Tests/
    ├── ViewModelTests/
    └── NetworkServiceTests/
```

---

## 🔌 Network Layer Concept

- Define endpoint once
- Reusable for any ViewModel
- Use generic `Decodable` response

Example call:

```swift
networkService.request(endpoint: .pokemonList, type: PokemonListResponse.self)
```

---

## 🧪 Unit Testing

Karena jaringan diabstract via protocol:

```swift
protocol NetworkServiceProtocol {
    func request<T: Decodable>(...) async throws -> T
}
```

Testing tidak membutuhkan internet:

```swift
let mockService = MockNetworkService(result: .success(mockData))
let viewModel = PokemonListViewModel(service: mockService)
```

---

## ▶️ How to Run

1. Clone repo
2. Open `.xcodeproj` or `.xcworkspace`
3. Run on iOS 17+ Simulator or real device

---

## 🌱 Roadmap

- [ ] Add Images Caching Example
- [ ] Add Pagination sample
- [ ] Add Retry + Circuit Breaker Pattern
- [ ] Combine + Async/Await comparison
- [ ] Add Clean Architecture layer separation

---

## 🤝 Contributions

Pull Requests welcome. Feel free to fork & modify.

---

## 📄 License

MIT — free to use for learning & production.
