# Technical Documentation - DECINT Admin Panel

## 🔧 Implementation Details

### Data Models and Structures

#### Intervention Model
```dart
Map<String, dynamic> intervention = {
  'id': String,           // Unique identifier (INT-XXX format)
  'name': String,         // Intervention name
  'latitude': double,     // GPS latitude (-90 to 90)
  'longitude': double,    // GPS longitude (-180 to 180)
  'startDate': String,    // Start date (YYYY-MM-DD format)
  'endDate': String,      // End date (YYYY-MM-DD format)
  'status': String,       // 'en cours', 'en pause', 'terminée'
};
```

#### User Model
```dart
Map<String, dynamic> user = {
  'id': String,           // Unique identifier (USR-XXX format)
  'name': String,         // Full name
  'email': String,        // Email address
  'profileType': String,  // One of 7 profile types
  'status': String,       // 'Active' or 'Inactive'
  'createdDate': String,  // Creation date (YYYY-MM-DD)
  'lastLogin': String,    // Last login date (YYYY-MM-DD)
};
```

#### Concessionaire Model
```dart
Map<String, dynamic> concessionaire = {
  'id': String,                    // Unique identifier (CON-XXX format)
  'name': String,                  // Company name
  'locations': List<Map<String, double>>,  // GPS coordinates
  'totalLocations': int,           // Number of locations
  'createdDate': String,           // Creation date
  'attachments': List<String>,     // File names
};
```

#### Report Model
```dart
Map<String, dynamic> report = {
  'type': String,                  // Report type
  'interventionId': String,        // Associated intervention
  'timestamp': String,             // Creation timestamp
  'subject': String?,              // Optional subject
  'description': String?,          // Optional description
  'attachedFiles': List<String>,   // File names
  'completionFiles': List<String>?, // Completion files
};
```

### Core Algorithms

#### Intervention Conflict Detection
```dart
Map<String, dynamic>? _checkInterventionConflict(
  double latitude,
  double longitude,
  String startDate,
  String endDate, {
  String? excludeId,
}) {
  final newStart = DateTime.parse(startDate);
  final newEnd = DateTime.parse(endDate);
  const tolerance = 0.0001; // ~11 meters

  for (final intervention in _interventions) {
    if (excludeId != null && intervention['id'] == excludeId) continue;
    if (intervention['status'] != 'en cours') continue;

    // GPS proximity check
    final latDiff = (intervention['latitude'] - latitude).abs();
    final lngDiff = (intervention['longitude'] - longitude).abs();
    
    if (latDiff <= tolerance && lngDiff <= tolerance) {
      // Date overlap check
      final existingStart = DateTime.parse(intervention['startDate']);
      final existingEnd = DateTime.parse(intervention['endDate']);
      
      if (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart)) {
        return intervention; // Conflict found
      }
    }
  }
  return null; // No conflict
}
```

#### File Picker Implementation
```dart
Future<void> _pickFiles() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
      withData: false,
      withReadStream: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _attachedFiles.addAll(result.files);
      });
    }
  } catch (e) {
    _handleFilePickerError(e);
  }
}
```

### State Management Patterns

#### Cross-Screen Data Sharing
```dart
class AnalyticsScreen extends StatefulWidget {
  // Static data storage for history
  static final List<Map<String, dynamic>> _historyList = [];
  static final Map<String, List<Map<String, dynamic>>> _historyReports = {};

  // Getter methods
  static List<Map<String, dynamic>> get historyList => 
      List.unmodifiable(_historyList);

  // Data manipulation methods
  static void addToHistory(Map<String, dynamic> entry) {
    final historyEntry = {...entry, 'timestamp': DateTime.now().toIso8601String()};
    _historyList.add(historyEntry);
    _historyReports[historyEntry['timestamp']] = [];
  }

  static void addReportToHistory(String historyTimestamp, Map<String, dynamic> report) {
    if (_historyReports.containsKey(historyTimestamp)) {
      _historyReports[historyTimestamp]!.add(report);
    }
  }
}
```

#### Callback-Based UI Updates
```dart
// Parent widget
void _showProgressReport(Map<String, dynamic> historyEntry) {
  showDialog(
    context: context,
    builder: (context) => _ReportDialog(
      // ... other parameters
      onReportSubmitted: () {
        setState(() {}); // Trigger UI refresh
      },
    ),
  );
}

// Child widget
void _submitReport() {
  // ... validation and data processing
  AnalyticsScreen.addReportToHistory(historyTimestamp, reportData);
  Navigator.of(context).pop();
  widget.onReportSubmitted(); // Trigger parent refresh
}
```

### Form Validation Patterns

#### Comprehensive Field Validation
```dart
TextFormField(
  controller: _latitudeController,
  decoration: const InputDecoration(
    labelText: 'Latitude *',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.my_location),
  ),
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Latitude is required';
    }
    final double? lat = double.tryParse(value);
    if (lat == null || lat < -90 || lat > 90) {
      return 'Please enter a valid latitude (-90 to 90)';
    }
    return null;
  },
),
```

#### Email Validation
```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
},
```

### UI Component Patterns

#### Statistics Card Component
```dart
Widget _buildStatCard(String title, String value, IconData icon, Color color) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 28),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    ),
  );
}
```

#### Modal Dialog Pattern
```dart
class _UserDialog extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? existingUser;
  final Function(Map<String, dynamic>) onUserSaved;

  const _UserDialog({
    required this.title,
    required this.onUserSaved,
    this.existingUser,
  });

  @override
  State<_UserDialog> createState() => _UserDialogState();
}
```

### Error Handling Strategies

#### File Picker Error Handling
```dart
void _handleFilePickerError(dynamic error) {
  String errorMessage = 'Error picking files';
  
  if (error.toString().contains('LateInitializationError')) {
    errorMessage = 'File picker not initialized. Please restart the app.';
  } else if (error.toString().contains('PlatformException')) {
    errorMessage = 'Permission denied. Please check file access permissions.';
  } else if (error.toString().contains('MissingPluginException')) {
    errorMessage = 'File picker plugin not available on this platform.';
  }

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Retry',
          onPressed: _pickFiles,
        ),
      ),
    );
  }
}
```

### Performance Optimization

#### ListView Builder for Large Datasets
```dart
Expanded(
  child: ListView.builder(
    itemCount: _users.length,
    itemBuilder: (context, index) {
      final user = _users[index];
      return _buildUserRow(user);
    },
  ),
)
```

#### File Upload Optimization
```dart
FilePickerResult? result = await FilePicker.platform.pickFiles(
  allowMultiple: true,
  type: FileType.any,
  withData: false,        // Don't load file data into memory
  withReadStream: false,  // Don't create read streams
);
```

### Security Considerations

#### Input Sanitization
- All user inputs are validated before processing
- Email format validation prevents malformed data
- GPS coordinate bounds checking prevents invalid locations
- Date validation ensures logical date ranges

#### File Upload Security
- File type validation through extensions
- File size limitations (handled by file_picker)
- Safe file name handling to prevent path traversal

### Testing Strategies

#### Widget Testing
```dart
testWidgets('User creation flow', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // Navigate to users screen
  await tester.tap(find.text('Users'));
  await tester.pumpAndSettle();
  
  // Open create user dialog
  await tester.tap(find.text('Add User'));
  await tester.pumpAndSettle();
  
  // Fill form and submit
  await tester.enterText(find.byType(TextFormField).first, 'Test User');
  await tester.tap(find.text('Create User'));
  await tester.pumpAndSettle();
  
  // Verify user was created
  expect(find.text('Test User'), findsOneWidget);
});
```

#### Unit Testing
```dart
test('Intervention conflict detection', () {
  final result = _checkInterventionConflict(
    45.5017, -73.5673,
    '2025-01-15', '2025-01-25',
  );
  
  expect(result, isNotNull);
  expect(result['id'], equals('INT-001'));
});
```

### Build Configuration

#### Platform-Specific Assets
```yaml
flutter:
  uses-material-design: true
  
  # Platform-specific icons
  # assets:
  #   - images/app_icon.png
  #   - images/logo.png
```

#### Build Commands
```bash
# Development build
flutter run --debug

# Release build
flutter build --release

# Platform-specific builds
flutter build windows --release
flutter build web --release
flutter build apk --release
```

### Deployment Considerations

#### Environment Configuration
- Development: Local file storage, debug logging
- Staging: Test database connections, limited features
- Production: Secure file storage, error reporting, analytics

#### Platform Distribution
- **Windows**: MSI installer or standalone executable
- **Web**: Static hosting (Firebase, Netlify, AWS S3)
- **Mobile**: App stores (Google Play, Apple App Store)

### Monitoring and Analytics

#### Error Tracking
- Implement crash reporting (Firebase Crashlytics)
- Log user actions for debugging
- Monitor performance metrics

#### User Analytics
- Track feature usage
- Monitor user engagement
- Analyze performance bottlenecks

---

This technical documentation provides detailed implementation insights for developers working on the DECINT admin panel project.