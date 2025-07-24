# bms_point_schedule_app

# BMS Point Schedule - South Beach Weligama

A Flutter application for Equipment Management System at South Beach Weligama resort. This app allows monitoring and controlling various building equipment including ESP Filters, HVAC systems, fuel systems, water management, and fire safety equipment.

## Features

### Authentication
- **Login System**: Secure login with hardcoded test credentials
  - Email: `admin@gmail.com`
  - Password: `@Admin123`
- **Auto-login**: Persistent authentication using local storage
- **Profile Management**: User profile view and logout functionality

### Dashboard
- **Equipment Overview**: Clean card-based layout showing all equipment
- **Search Functionality**: Real-time search across equipment names, types, and locations
- **Categorized View**: Equipment grouped by type (Air Filtration, HVAC, Fuel System, etc.)
- **Grid Layout**: 2 cards per row for optimal tablet/phone viewing

### Equipment Management
- **Equipment List**: View equipment by category with quantity-based instances
- **Equipment Details**: Comprehensive view of each equipment unit including:
  - Properties and values
  - Control options (for controllable equipment)
  - Status monitoring
  - Location information
  - Last update timestamps

### Navigation
- **App Drawer**: Easy navigation with equipment categories and user actions
- **Breadcrumb Navigation**: Clear navigation path through screens
- **Profile Access**: Quick access to user profile from dashboard

## Equipment Categories Included
1. **ESP Filter** (Air Filtration)
2. **Lobby Pressurization Fans** (HVAC) 
3. **Fuel Systems** (Day Tank & Bulk Tank)
4. **Sewer Station** (Water Management)
5. **Hydrant Pump** (Fire Safety)

## Installation & Setup

1. **Prerequisites**: Flutter SDK (3.5.3 or higher)
2. **Run Commands**:
   ```bash
   flutter pub get
   flutter run
   ```

## Usage

### Login
Use the test credentials:
- Email: `admin@gmail.com`
- Password: `@Admin123`

### Navigation
1. **Dashboard**: Main screen with equipment categories
2. **Search**: Find specific equipment
3. **Equipment Details**: Tap cards to view properties and controls
4. **Drawer Menu**: Access categories and user options

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
