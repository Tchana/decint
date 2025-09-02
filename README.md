# DECINT - Flutter Admin Panel

A comprehensive Flutter-based administration panel for intervention management, user administration, and concessionaire oversight.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Modules](#modules)
- [Dependencies](#dependencies)
- [Development](#development)
- [Contributing](#contributing)

## 🎯 Overview

DECINT is a modern, cross-platform admin panel built with Flutter that provides comprehensive management capabilities for interventions, users, concessionaires, and operational history. The application features a responsive design with role-based access control and real-time data management.

### Key Capabilities
- **Intervention Management**: Create, track, and manage field interventions with GPS coordinates and conflict detection
- **User Administration**: Manage users across 7 different profile types with role-based permissions
- **Concessionaire Management**: Oversee concessionaire data with document attachments and location tracking
- **History Tracking**: Comprehensive audit trail with report generation capabilities
- **Document Management**: File attachment system with multiple format support

## ✨ Features

### 🏠 Dashboard
- Real-time statistics and metrics
- Quick access to key functionalities
- Visual data representation with charts

### 🚨 Intervention Management
- **CRUD Operations**: Create, read, update, and delete interventions
- **GPS Integration**: Latitude/longitude tracking with conflict detection
- **Status Management**: Track intervention states (en cours, en pause, terminée)
- **Conflict Prevention**: Automatic detection of overlapping interventions
- **Date Range Validation**: Prevent scheduling conflicts

### 👥 User Management
- **Multi-Profile Support**: 7 distinct user profiles
  - Admin
  - Maître d'ouvrage
  - Concessionaire
  - CTD
  - BET
  - Entreprise de travaux
  - Lecteur
- **User Lifecycle**: Create, edit, activate/deactivate users
- **Email Validation**: Built-in email format verification
- **Status Tracking**: Active/Inactive user states

### 🏢 Concessionaire Management
- **Company Profiles**: Comprehensive concessionaire information
- **Multi-Location Support**: Multiple GPS coordinates per concessionaire
- **Document Attachments**: File upload and management system
- **Location Mapping**: Visual representation of concessionaire locations

### 📊 History & Reporting
- **Audit Trail**: Complete action history with timestamps
- **Accordion Interface**: Expandable history entries
- **Report Generation**: 4 types of reports
  - Progress Reports
  - Incident Reports
  - Completion Reports
  - General Reports
- **File Attachments**: Document support for all report types
- **Real-time Updates**: Automatic UI refresh on report submission

## 🏗 Architecture

### Project Structure
```
lib/
├── main.dart                 # Application entry point
├── widgets/
│   └── admin_layout.dart     # Main layout with navigation
└── screens/
    ├── dashboard_screen.dart     # Dashboard overview
    ├── users_screen.dart         # User management
    ├── analytics_screen.dart     # Intervention management
    ├── history_screen.dart       # History & reporting
    └── settings_screen.dart      # Concessionaire management
```

### Design Patterns
- **StatefulWidget/StatelessWidget**: Reactive UI components
- **Callback Pattern**: Parent-child communication
- **Static Data Management**: Cross-screen data sharing
- **Modal Dialog Pattern**: Form-based interactions
- **Card-Based Layout**: Consistent visual design

### Color Scheme
- **Primary**: Blue (#667eea)
- **Secondary**: Purple (#764ba2)
- **Success**: Green
- **Warning**: Orange
- **Danger**: Red
- **Info**: Indigo

## 🚀 Installation

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (bundled with Flutter)
- Development IDE (VS Code, Android Studio, or IntelliJ)
- Git for version control

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd decint
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Windows
```bash
flutter run -d windows
```

#### Web
```bash
flutter run -d chrome
```

#### Mobile (Android/iOS)
```bash
flutter run
```

## 📖 Usage

### Navigation
The application features a sidebar navigation with 5 main sections:
- **Dashboard**: Overview and statistics
- **Users**: User management interface
- **Interventions**: Intervention tracking and management
- **History**: Action history and reporting
- **Concessionaires**: Concessionaire management

### Core Workflows

#### Creating an Intervention
1. Navigate to Interventions screen
2. Click "Create Intervention" button
3. Fill required fields:
   - Name
   - Latitude/Longitude coordinates
   - Start and end dates
   - Status selection
4. System validates for conflicts
5. Intervention created with automatic history logging

#### Managing Users
1. Navigate to Users screen
2. Click "Add User" button
3. Complete user form:
   - Full name
   - Email address
   - Profile type selection
   - Status setting
4. Submit to create user account

#### Generating Reports
1. Navigate to History screen
2. Expand any intervention entry
3. Select report type:
   - Progress Report
   - Incident Report
   - Completion Report
   - General Report
4. Fill report details and attach files
5. Submit for automatic inclusion in history

## 📦 Modules

### 1. Dashboard Module
**Location**: `lib/screens/dashboard_screen.dart`
- System overview and metrics
- Quick action buttons
- Visual data representation

### 2. User Management Module
**Location**: `lib/screens/users_screen.dart`
- User CRUD operations
- Profile type management
- Status control
- Email validation

### 3. Intervention Management Module
**Location**: `lib/screens/analytics_screen.dart`
- Intervention lifecycle management
- GPS coordinate validation
- Conflict detection algorithm
- Status workflow management

### 4. History & Reporting Module
**Location**: `lib/screens/history_screen.dart`
- Action audit trail
- Report generation system
- File attachment handling
- Real-time UI updates

### 5. Concessionaire Management Module
**Location**: `lib/screens/settings_screen.dart`
- Company profile management
- Multi-location support
- Document management system
- File upload capabilities

### 6. Layout Module
**Location**: `lib/widgets/admin_layout.dart`
- Navigation sidebar
- Screen routing
- Responsive layout
- User interface consistency

## 🔧 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  fl_chart: ^0.66.0           # Charts and data visualization
  font_awesome_flutter: ^10.6.0  # Enhanced icon set
  responsive_builder: ^0.7.0   # Responsive design utilities
  file_picker: ^8.1.2         # File selection and upload
```

### Development Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0       # Code quality and style enforcement
```

## 💻 Development

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Implement proper error handling
- Add comprehensive comments for complex logic

### State Management
- **Local State**: StatefulWidget for component-specific state
- **Cross-Screen State**: Static methods and variables
- **Form State**: GlobalKey<FormState> for validation

### File Structure Guidelines
- Separate screens into individual files
- Use descriptive file names
- Group related functionality
- Maintain consistent import ordering

### Best Practices
- **Validation**: Implement form validation for all user inputs
- **Error Handling**: Provide user-friendly error messages
- **Performance**: Use ListView.builder for large datasets
- **Accessibility**: Include proper semantics and labels
- **Responsiveness**: Test on multiple screen sizes

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart
```

### Building for Production
```bash
# Web
flutter build web

# Windows
flutter build windows

# Android
flutter build apk

# iOS
flutter build ios
```

## 🤝 Contributing

### Development Workflow
1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Submit pull request with detailed description

### Code Review Process
- All changes require review
- Ensure tests pass
- Follow established coding standards
- Update documentation as needed

### Issue Reporting
- Use GitHub issues for bug reports
- Provide detailed reproduction steps
- Include platform and version information

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Contact the development team
- Check documentation and FAQ

---

**Built with ❤️ using Flutter**