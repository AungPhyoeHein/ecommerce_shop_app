# Ecommerce Shop App (Full-stack Project)

A professional Flutter e-commerce application built with **Clean Architecture** & **BLoC/Cubit pattern**.

## 🌟 Key Highlights
- **Clean Architecture:** Separated into Data, Domain, and Presentation layers for high maintainability.
- **State Management:** Utilizes **BLoC/Cubit** for predictable state transitions.
- **Full-stack Integration:** Powered by a Node.js RESTful API with MongoDB/Mongoose.


## 🚀 Current Progress (Features)
- [x] Persistent User Login (Session management)
- [x] Home Screen UI 
- [x] State Management with Cubit
- [x] Responsive Drawer Navigation
- [x] Error Handling with Custom Snackbars
- [x] Caching logics
- [x] Product Detail UI
- [ ] Review Bottom Sheet (Progressing)
- [ ] Other Features (Coming Soon)

## 🛠 Tech Stack
- **Frontend:** Flutter (Dart)
- **Backend:** Node.js, Express.js
- **Database:** MongoDB with Mongoose ODM
- **State Management:** BLoC / Cubit
- **Architecture:** Clean Architecture

## 🏗 Project Structure
The project is organized following the separation of concerns principle:
```text
lib/
├── core/            # Reusable widgets, themes, constants, and network utilities.
├── src/             # Feature-based modules
│   ├── login/       # Authentication logic and UI
│   ├── home/        # Dashboard and product listings
│   └── product/     # Product details and review features
└── main.dart        # Entry point