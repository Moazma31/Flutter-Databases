# Flutter-Databases
Feat: From basic to Advanced Level Flutter on Dart using databases
# Notes App

## 1. Project Overview

The Notes App is a simple application made using Flutter and Dart. It helps users create, view, edit, and delete their notes.

The main purpose of this project is to learn how to build a Flutter application and store data in a database.

## 2. Objectives

- To create a simple and user-friendly Notes App.
- To add new notes with a title and content.
- To edit and delete existing notes.
- To store notes in a database.
- To learn how to connect a Flutter application with a database.
- To support running the application on Chrome and Android.

## 3. Technologies Used

- **Flutter:** Used to build the application interface.
- **Dart:** Used to write the application logic.
- **SQLite:** Used to store notes in a database.
- **Chrome:** Used to run and test the web version of the application.

## 4. Dependencies Used

| Dependency | Purpose |
|---|---|
| `flutter/material.dart` | Provides widgets such as AppBar, TextField, Button, and ListView. |
| `sqflite` | Provides SQLite database operations on supported mobile platforms. |
| `path` | Helps create and manage database file paths. |
| `sqflite_common_ffi_web` | Provides web database support for running the app in a browser. |

## 5. Project File Structure

### `lib/main.dart`

This is the main file of the application. It starts the app and displays the Notes screen.

It contains the user interface and the functions to add, view, edit, and delete notes.

### `lib/models/note.dart`

This file defines the Note model. It stores the note's ID, title, content, and creation date.

It also converts note data into a map for database operations and converts database records back into Note objects.

### `lib/database/database_helper.dart`

This file manages database operations. It contains functions to:

- Create and initialize the database.
- Insert new notes.
- Retrieve saved notes.
- Update existing notes.
- Delete notes.

It also selects the appropriate database setup for web and supported mobile platforms.

## 6. Main Features

- Add a new note.
- View all saved notes.
- Edit a note by tapping it.
- Delete a note using the delete icon.
- Store notes in a database.
- Keep saved notes available after refreshing the browser, provided the browser's stored data is not cleared and the same application origin is used.

## 7. How to Run the Project

First, install Flutter and set up the required development environment.

Open the project folder in VS Code and run:

```bash
flutter pub get
```

To run the application in Chrome:

```bash
flutter run -d chrome
```

To run the application on an available Android device or emulator:

```bash
flutter run
```

## 8. How to Use the App

1. Open the application.
2. Press the `+` button to add a note.
3. Enter the title and content.
4. Press Save.
5. Tap an existing note to edit it.
6. Press the delete icon to remove a note.

## 9. Learning Outcomes

Through this project, I learned how to create a Flutter user interface, work with Dart classes, use a model to organize data, connect an application to a database, and perform basic database operations.

## 10. Conclusion

The Notes App is a basic Flutter project that demonstrates how to build a simple application with database functionality. It provides the basic features required to manage personal notes and helps develop practical skills in Flutter and database programming.
