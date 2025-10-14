# Time Tracker App - Screenshot Guide

This Flutter app has been designed to fulfill all the requirements for your mobile assignment screenshots. Here's a comprehensive guide to capture all the required screenshots.

## App Overview

The Time Tracker app includes:
- **Home Screen**: Shows time entries with empty state and grouped views
- **Project Management**: Manage projects with add/delete functionality
- **Task Management**: Manage tasks linked to projects
- **Local Storage**: View all stored data
- **Add Time Entry**: Form with project/task dropdowns

## Required Screenshots

### 1. home-empty.png
**How to capture:**
1. Launch the app (it starts with empty state)
2. Take screenshot of the home screen showing "No time entries yet" message

### 2. home-empty-group.png
**How to capture:**
1. On home screen, tap the "By Project" tab
2. Take screenshot showing empty state in grouped view

### 3. entry-project-list.png
**How to capture:**
1. Tap the "+" button on home screen to add time entry
2. Tap the "Project Name" dropdown
3. Take screenshot showing the dropdown list

### 4. entry-task-list.png
**How to capture:**
1. In add time entry screen, select a project first
2. Tap the "Task Name" dropdown
3. Take screenshot showing the task dropdown list

### 5. entry-add.png
**How to capture:**
1. In add time entry screen, fill in all fields:
   - Total Time: "2:30"
   - Project Name: Select any project
   - Task Name: Select any task
   - Notes: "Sample time entry"
   - Date: Select current date
2. Take screenshot before tapping "Save Time Entry"

### 6. home-entries.png
**How to capture:**
1. Load demo data (tap the data icon floating button)
2. Go to home screen "All Entries" tab
3. Take screenshot showing multiple time entries

### 7. home-entries-group.png
**How to capture:**
1. With demo data loaded, go to home screen
2. Tap "By Project" tab
3. Take screenshot showing entries grouped by projects

### 8. entry-delete.png
**How to capture:**
1. With demo data loaded, go to home screen
2. Tap the delete (trash) icon on any time entry
3. Take screenshot showing the delete confirmation dialog

### 9. menu.png
**How to capture:**
1. The app uses bottom navigation instead of hamburger menu
2. Take screenshot showing the Menu

### 10. project-management.png
**How to capture:**
1. Tap "Projects" in bottom navigation
2. Take screenshot showing project list with floating "+" button

### 11. project-add.png
**How to capture:**
1. In project management screen, tap the "+" button
2. Fill in project name and description
3. Take screenshot showing the add project dialog

### 12. task-management.png
**How to capture:**
1. Tap "Tasks" in bottom navigation
2. Take screenshot showing task list with floating "+" button

### 13. task-add.png
**How to capture:**
1. In task management screen, tap the "+" button
2. Fill in task name, description, and select project
3. Take screenshot showing the add task dialog

### 14. local-storage-empty.png
**How to capture:**
1. Clear all data (in storage screen, tap clear all button)
2. Go to "Storage" tab
3. Take screenshot showing empty storage state

### 15. local-storage-filled.png
**How to capture:**
1. Load demo data (tap data icon)
2. Go to "Storage" tab
3. Take screenshot showing all stored data (time entries, projects, tasks)

## Demo Data

The app includes a demo data service that populates the app with sample data:
- 3 sample projects
- 5 sample tasks
- 5 sample time entries

To load demo data:
1. Tap the floating action button with data icon
2. Confirm in the dialog

To clear all data:
1. Go to Storage tab
2. Tap the clear all button (trash icon in app bar)

## Navigation

The app uses bottom navigation with 4 tabs:
- **Home**: Time entries with empty state and grouping
- **Projects**: Project management
- **Tasks**: Task management  
- **Storage**: Local storage view

## Key Features

- **Empty States**: Proper empty state messages for all screens
- **Data Persistence**: Uses SharedPreferences for local storage
- **CRUD Operations**: Create, Read, Update, Delete for all entities
- **Form Validation**: Proper form validation in add screens
- **Confirmation Dialogs**: Delete confirmations for data safety
- **Grouping**: Time entries can be viewed grouped by project
- **Real-time Updates**: UI updates immediately after data changes

## Technical Implementation

- **State Management**: StatefulWidget with setState
- **Data Models**: TimeEntry, Project, Task with JSON serialization
- **Local Storage**: SharedPreferences with DataService
- **Navigation**: Bottom navigation with TabBarView
- **UI Components**: Material Design 3 with proper theming
- **Form Handling**: TextFormField with validation
- **Date Picking**: Built-in date picker
- **Time Formatting**: Custom time formatting (hours:minutes)

This app provides all the functionality needed to capture the required screenshots for your mobile assignment.
