# API Documentation - DECINT Admin Panel

## Overview

This document outlines the internal API structure and data interfaces used throughout the DECINT Flutter admin panel. While the current implementation uses static data management, this documentation serves as a blueprint for future backend integration.

## Core Data Interfaces

### Intervention API

#### Data Structure
```dart
class Intervention {
  final String id;              // Format: INT-XXX
  final String name;
  final double latitude;        // Range: -90 to 90
  final double longitude;       // Range: -180 to 180
  final String startDate;       // Format: YYYY-MM-DD
  final String endDate;         // Format: YYYY-MM-DD
  final String status;          // Values: 'en cours', 'en pause', 'terminée'
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

#### Available Operations
```dart
// Create new intervention
Future<Intervention> createIntervention(InterventionRequest request);

// Get all interventions
Future<List<Intervention>> getInterventions();

// Get intervention by ID
Future<Intervention?> getIntervention(String id);

// Update intervention
Future<Intervention> updateIntervention(String id, InterventionRequest request);

// Delete intervention
Future<bool> deleteIntervention(String id);

// Check for conflicts
Future<Intervention?> checkConflict(ConflictCheckRequest request);
```

#### Request/Response Models
```dart
class InterventionRequest {
  final String name;
  final double latitude;
  final double longitude;
  final String startDate;
  final String endDate;
  final String status;
}

class ConflictCheckRequest {
  final double latitude;
  final double longitude;
  final String startDate;
  final String endDate;
  final String? excludeId;  // For update operations
}

class ConflictResponse {
  final bool hasConflict;
  final Intervention? conflictingIntervention;
  final String? reason;
}
```

### User Management API

#### Data Structure
```dart
class User {
  final String id;              // Format: USR-XXX
  final String name;
  final String email;
  final ProfileType profileType;
  final UserStatus status;
  final DateTime createdDate;
  final DateTime? lastLogin;
}

enum ProfileType {
  admin,
  maitreDouvrage,
  concessionaire,
  ctd,
  bet,
  entrepriseDeTravaux,
  lecteur
}

enum UserStatus {
  active,
  inactive
}
```

#### Available Operations
```dart
// Create new user
Future<User> createUser(UserRequest request);

// Get all users
Future<List<User>> getUsers();

// Get user by ID
Future<User?> getUser(String id);

// Update user
Future<User> updateUser(String id, UserRequest request);

// Toggle user status
Future<User> toggleUserStatus(String id);

// Delete user
Future<bool> deleteUser(String id);

// Get users by profile type
Future<List<User>> getUsersByProfile(ProfileType profileType);
```

#### Request/Response Models
```dart
class UserRequest {
  final String name;
  final String email;
  final ProfileType profileType;
  final UserStatus status;
}

class UserResponse {
  final List<User> users;
  final int totalCount;
  final Map<ProfileType, int> profileTypeCounts;
  final Map<UserStatus, int> statusCounts;
}
```

### Concessionaire Management API

#### Data Structure
```dart
class Concessionaire {
  final String id;              // Format: CON-XXX
  final String name;
  final List<Location> locations;
  final List<String> attachments;
  final DateTime createdDate;
  final DateTime updatedDate;
}

class Location {
  final double latitude;
  final double longitude;
  final String? description;
}
```

#### Available Operations
```dart
// Create new concessionaire
Future<Concessionaire> createConcessionaire(ConcessionaireRequest request);

// Get all concessionaires
Future<List<Concessionaire>> getConcessionaires();

// Get concessionaire by ID
Future<Concessionaire?> getConcessionaire(String id);

// Update concessionaire
Future<Concessionaire> updateConcessionaire(String id, ConcessionaireRequest request);

// Delete concessionaire
Future<bool> deleteConcessionaire(String id);

// Upload attachments
Future<List<String>> uploadAttachments(String id, List<File> files);
```

#### Request/Response Models
```dart
class ConcessionaireRequest {
  final String name;
  final List<Location> locations;
}

class ConcessionaireResponse {
  final List<Concessionaire> concessionaires;
  final int totalCount;
  final int totalLocations;
  final double averageLocationsPerConcessionaire;
}
```

### History & Reporting API

#### Data Structure
```dart
class HistoryEntry {
  final String id;
  final String action;          // Values: 'CREATED', 'UPDATED', 'CONFLICT', 'EDIT_CONFLICT'
  final DateTime timestamp;
  final Intervention intervention;
  final String? reason;
  final Intervention? conflictWith;
  final Intervention? originalIntervention;
}

class Report {
  final String id;
  final ReportType type;
  final String interventionId;
  final String historyTimestamp;
  final DateTime createdAt;
  final String? subject;
  final String? description;
  final List<String> attachedFiles;
  final List<String>? completionFiles;
}

enum ReportType {
  progress,
  incident,
  completion,
  general
}
```

#### Available Operations
```dart
// Get history entries
Future<List<HistoryEntry>> getHistory();

// Add history entry
Future<HistoryEntry> addHistoryEntry(HistoryEntryRequest request);

// Create report
Future<Report> createReport(ReportRequest request);

// Get reports for history entry
Future<List<Report>> getReportsForHistory(String historyTimestamp);

// Upload report attachments
Future<List<String>> uploadReportFiles(List<File> files);
```

#### Request/Response Models
```dart
class HistoryEntryRequest {
  final String action;
  final Map<String, dynamic> intervention;
  final String? reason;
  final Map<String, dynamic>? conflictWith;
  final Map<String, dynamic>? originalIntervention;
}

class ReportRequest {
  final ReportType type;
  final String interventionId;
  final String historyTimestamp;
  final String? subject;
  final String? description;
  final List<String> attachedFiles;
  final List<String>? completionFiles;
}
```

## File Management API

#### File Upload Interface
```dart
class FileUploadService {
  // Upload single file
  static Future<String> uploadFile(File file);
  
  // Upload multiple files
  static Future<List<String>> uploadFiles(List<File> files);
  
  // Get file URL
  static Future<String> getFileUrl(String fileName);
  
  // Delete file
  static Future<bool> deleteFile(String fileName);
  
  // Get file metadata
  static Future<FileMetadata> getFileMetadata(String fileName);
}

class FileMetadata {
  final String fileName;
  final String originalName;
  final int fileSize;
  final String mimeType;
  final DateTime uploadedAt;
}
```

## Error Handling

### Standard Error Response
```dart
class ApiError {
  final int code;
  final String message;
  final String? details;
  final DateTime timestamp;
}

// Common error codes
enum ErrorCode {
  validation_error(400),
  not_found(404),
  conflict_detected(409),
  server_error(500);
}
```

### Error Handling Examples
```dart
try {
  final intervention = await createIntervention(request);
  return intervention;
} catch (ApiError e) {
  switch (e.code) {
    case 409:  // Conflict
      showConflictDialog(e.details);
      break;
    case 400:  // Validation
      showValidationErrors(e.details);
      break;
    default:
      showGenericError(e.message);
  }
}
```

## Authentication API (Future Implementation)

#### Data Structure
```dart
class AuthUser {
  final String id;
  final String email;
  final String name;
  final ProfileType profileType;
  final List<Permission> permissions;
  final DateTime lastLogin;
}

class Permission {
  final String resource;
  final List<String> actions;  // ['create', 'read', 'update', 'delete']
}
```

#### Authentication Operations
```dart
// Login
Future<AuthResponse> login(LoginRequest request);

// Logout
Future<void> logout();

// Refresh token
Future<AuthResponse> refreshToken(String refreshToken);

// Get current user
Future<AuthUser> getCurrentUser();

// Check permissions
Future<bool> hasPermission(String resource, String action);
```

## Data Validation Rules

### Intervention Validation
```dart
class InterventionValidator {
  static ValidationResult validateLatitude(double latitude) {
    if (latitude < -90 || latitude > 90) {
      return ValidationResult.error('Latitude must be between -90 and 90');
    }
    return ValidationResult.success();
  }
  
  static ValidationResult validateLongitude(double longitude) {
    if (longitude < -180 || longitude > 180) {
      return ValidationResult.error('Longitude must be between -180 and 180');
    }
    return ValidationResult.success();
  }
  
  static ValidationResult validateDateRange(String startDate, String endDate) {
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    
    if (start.isAfter(end)) {
      return ValidationResult.error('Start date must be before end date');
    }
    return ValidationResult.success();
  }
}
```

### User Validation
```dart
class UserValidator {
  static ValidationResult validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return ValidationResult.error('Invalid email format');
    }
    return ValidationResult.success();
  }
  
  static ValidationResult validateProfileType(String profileType) {
    final validTypes = ['Admin', 'Maitre d\'ouvrage', 'Concessionaire', 
                       'CTD', 'BET', 'Entreprise de travaux', 'Lecteur'];
    if (!validTypes.contains(profileType)) {
      return ValidationResult.error('Invalid profile type');
    }
    return ValidationResult.success();
  }
}
```

## Integration Guidelines

### Backend Integration Checklist
- [ ] Implement REST API endpoints following the documented interface
- [ ] Add proper authentication and authorization
- [ ] Implement file upload service with secure storage
- [ ] Add database persistence layer
- [ ] Implement proper error handling and logging
- [ ] Add API rate limiting and security measures
- [ ] Create API documentation with OpenAPI/Swagger
- [ ] Implement data backup and recovery procedures

### Frontend Migration Steps
1. Replace static data management with API calls
2. Implement proper loading states and error handling
3. Add authentication flow and token management
4. Update state management to handle async operations
5. Implement offline capabilities if needed
6. Add proper caching mechanisms
7. Update error handling to match API responses

---

This API documentation provides a comprehensive blueprint for implementing a backend service for the DECINT admin panel, ensuring consistency between frontend expectations and backend implementation.