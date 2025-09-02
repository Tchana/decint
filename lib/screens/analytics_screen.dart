import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  // Static list to store history - in a real app this would be stored in a database
  static final List<Map<String, dynamic>> _historyList = [];

  // Static list to store reports for each history entry
  static final Map<String, List<Map<String, dynamic>>> _historyReports = {};

  // Static getter to access history from other screens
  static List<Map<String, dynamic>> get historyList =>
      List.unmodifiable(_historyList);

  // Static getter to access reports from other screens
  static Map<String, List<Map<String, dynamic>>> get historyReports =>
      Map.unmodifiable(_historyReports);

  // Static method to add history entry
  static void addToHistory(Map<String, dynamic> entry) {
    final historyEntry = {
      ...entry,
      'timestamp': DateTime.now().toIso8601String(),
    };
    _historyList.add(historyEntry);
    // Initialize empty reports list for this history entry
    _historyReports[historyEntry['timestamp']] = [];
  }

  // Static method to add report to a history entry
  static void addReportToHistory(
    String historyTimestamp,
    Map<String, dynamic> report,
  ) {
    if (_historyReports.containsKey(historyTimestamp)) {
      _historyReports[historyTimestamp]!.add(report);
    }
  }

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  // Sample data for interventions
  final List<Map<String, dynamic>> _interventions = [
    {
      'id': 'INT-001',
      'name': 'Emergency Response Training',
      'latitude': 45.5017,
      'longitude': -73.5673,
      'startDate': '2025-01-15',
      'endDate': '2025-01-25',
      'status': 'en cours',
    },
    {
      'id': 'INT-002',
      'name': 'Safety Protocol Update',
      'latitude': 45.4215,
      'longitude': -75.6972,
      'startDate': '2025-01-10',
      'endDate': '2025-01-15',
      'status': 'terminée',
    },
    {
      'id': 'INT-003',
      'name': 'Equipment Maintenance',
      'latitude': 46.8139,
      'longitude': -71.2082,
      'startDate': '2025-01-20',
      'endDate': '2025-01-30',
      'status': 'en pause',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and create button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Interventions',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _createIntervention,
                  icon: const Icon(Icons.add),
                  label: const Text('Create Intervention'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Interventions',
                    _interventions.length.toString(),
                    Icons.assignment,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Active',
                    _interventions
                        .where((i) => i['status'] == 'en cours')
                        .length
                        .toString(),
                    Icons.play_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Paused',
                    _interventions
                        .where((i) => i['status'] == 'en pause')
                        .length
                        .toString(),
                    Icons.pause_circle,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Completed',
                    _interventions
                        .where((i) => i['status'] == 'terminée')
                        .length
                        .toString(),
                    Icons.check_circle,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Interventions Table
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Intervention List',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Table Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'ID',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Latitude',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Longitude',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Start Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'End Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Actions',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Table Data
                      Expanded(
                        child: ListView.builder(
                          itemCount: _interventions.length,
                          itemBuilder: (context, index) {
                            final intervention = _interventions[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(intervention['id']),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(intervention['name']),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      intervention['latitude'].toString(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      intervention['longitude'].toString(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(intervention['startDate']),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(intervention['endDate']),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(
                                          intervention['status'],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        intervention['status'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: PopupMenuButton<String>(
                                      onSelected: (value) {
                                        _handleAction(value, intervention);
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit, size: 16),
                                              SizedBox(width: 8),
                                              Text('Edit'),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      child: const Icon(Icons.more_vert),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
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
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'en cours':
        return Colors.green;
      case 'en pause':
        return Colors.orange;
      case 'terminée':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _createIntervention() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _CreateInterventionDialog(
          onInterventionCreated: (intervention) {
            // Check for conflicts before adding
            final conflict = _checkInterventionConflict(
              intervention['latitude'],
              intervention['longitude'],
              intervention['startDate'],
              intervention['endDate'],
              excludeId: null, // No exclusion for new interventions
            );

            if (conflict != null) {
              // Add conflict to history
              AnalyticsScreen.addToHistory({
                'action': 'CONFLICT',
                'intervention': intervention,
                'conflictWith': conflict,
                'reason': 'Location and date overlap with ongoing intervention',
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'There is an ongoing intervention at this location and time period.',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Add successful creation to history
            AnalyticsScreen.addToHistory({
              'action': 'CREATED',
              'intervention': intervention,
            });

            setState(() {
              _interventions.add(intervention);
            });
          },
        );
      },
    );
  }

  void _handleAction(String action, Map<String, dynamic> intervention) {
    switch (action) {
      case 'edit':
        _editIntervention(intervention);
        break;
      case 'delete':
        _showDeleteConfirmation(intervention);
        break;
    }
  }

  void _editIntervention(Map<String, dynamic> intervention) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _EditInterventionDialog(
          intervention: intervention,
          onInterventionUpdated: (updatedIntervention) {
            // Check for conflicts before updating
            final conflict = _checkInterventionConflict(
              updatedIntervention['latitude'],
              updatedIntervention['longitude'],
              updatedIntervention['startDate'],
              updatedIntervention['endDate'],
              excludeId:
                  intervention['id'], // Exclude current intervention from conflict check
            );

            if (conflict != null) {
              // Add conflict to history
              AnalyticsScreen.addToHistory({
                'action': 'EDIT_CONFLICT',
                'intervention': updatedIntervention,
                'originalIntervention': intervention,
                'conflictWith': conflict,
                'reason': 'Location and date overlap with ongoing intervention',
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'There is an ongoing intervention at this location and time period.',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Add successful edit to history
            AnalyticsScreen.addToHistory({
              'action': 'UPDATED',
              'intervention': updatedIntervention,
              'originalIntervention': intervention,
            });

            setState(() {
              final index = _interventions.indexWhere(
                (item) => item['id'] == intervention['id'],
              );
              if (index != -1) {
                _interventions[index] = updatedIntervention;
              }
            });
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> intervention) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Intervention'),
          content: Text(
            'Are you sure you want to delete "${intervention['name']}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _interventions.removeWhere(
                    (item) => item['id'] == intervention['id'],
                  );
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Intervention deleted successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  /// Check if there's a conflict with an ongoing intervention at the same location and overlapping dates
  Map<String, dynamic>? _checkInterventionConflict(
    double latitude,
    double longitude,
    String startDate,
    String endDate, {
    String? excludeId,
  }) {
    final newStart = DateTime.parse(startDate);
    final newEnd = DateTime.parse(endDate);

    for (final intervention in _interventions) {
      // Skip if this is the intervention being edited
      if (excludeId != null && intervention['id'] == excludeId) {
        continue;
      }

      // Only check against ongoing interventions
      if (intervention['status'] != 'en cours') {
        continue;
      }

      // Check if coordinates match (with small tolerance for floating point comparison)
      final latDiff = (intervention['latitude'] - latitude).abs();
      final lngDiff = (intervention['longitude'] - longitude).abs();
      const tolerance = 0.0001; // About 11 meters

      if (latDiff <= tolerance && lngDiff <= tolerance) {
        // Coordinates match, now check date overlap
        final existingStart = DateTime.parse(intervention['startDate']);
        final existingEnd = DateTime.parse(intervention['endDate']);

        // Check if date ranges overlap
        if (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart)) {
          return intervention; // Found a conflict
        }
      }
    }

    return null; // No conflict found
  }
}

class _CreateInterventionDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onInterventionCreated;

  const _CreateInterventionDialog({required this.onInterventionCreated});

  @override
  State<_CreateInterventionDialog> createState() =>
      _CreateInterventionDialogState();
}

class _CreateInterventionDialogState extends State<_CreateInterventionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  String _selectedStatus = 'en cours';

  final List<String> _statusOptions = ['en cours', 'en pause', 'terminée'];

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Create New Intervention',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D3748),
        ),
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Latitude field
                TextFormField(
                  controller: _latitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Latitude *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.my_location),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
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
                const SizedBox(height: 16),

                // Longitude field
                TextFormField(
                  controller: _longitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Longitude *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.place),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Longitude is required';
                    }
                    final double? lng = double.tryParse(value);
                    if (lng == null || lng < -180 || lng > 180) {
                      return 'Please enter a valid longitude (-180 to 180)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Start Date field
                TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(
                    labelText: 'Start Date *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'YYYY-MM-DD',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      _startDateController.text =
                          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Start date is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // End Date field
                TextFormField(
                  controller: _endDateController,
                  decoration: const InputDecoration(
                    labelText: 'End Date *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event),
                    hintText: 'YYYY-MM-DD',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      _endDateController.text =
                          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'End date is required';
                    }
                    // Validate that end date is after start date
                    if (_startDateController.text.isNotEmpty) {
                      final startDate = DateTime.parse(
                        _startDateController.text,
                      );
                      final endDate = DateTime.parse(value);
                      if (endDate.isBefore(startDate)) {
                        return 'End date must be after start date';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Status dropdown
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.info),
                  ),
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedStatus = newValue;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Status is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Create Intervention'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Generate a unique ID
      final int nextId = DateTime.now().millisecondsSinceEpoch % 1000;
      final String interventionId = 'INT-${nextId.toString().padLeft(3, '0')}';

      // Create the intervention data
      final Map<String, dynamic> newIntervention = {
        'id': interventionId,
        'name': _nameController.text.trim(),
        'latitude': double.parse(_latitudeController.text.trim()),
        'longitude': double.parse(_longitudeController.text.trim()),
        'startDate': _startDateController.text.trim(),
        'endDate': _endDateController.text.trim(),
        'status': _selectedStatus,
      };

      // Call the callback function
      widget.onInterventionCreated(newIntervention);

      // Close the dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Intervention "${newIntervention['name']}" created successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}

class _EditInterventionDialog extends StatefulWidget {
  final Map<String, dynamic> intervention;
  final Function(Map<String, dynamic>) onInterventionUpdated;

  const _EditInterventionDialog({
    required this.intervention,
    required this.onInterventionUpdated,
  });

  @override
  State<_EditInterventionDialog> createState() =>
      _EditInterventionDialogState();
}

class _EditInterventionDialogState extends State<_EditInterventionDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late String _selectedStatus;

  final List<String> _statusOptions = ['en cours', 'en pause', 'terminée'];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    _nameController = TextEditingController(text: widget.intervention['name']);
    _latitudeController = TextEditingController(
      text: widget.intervention['latitude'].toString(),
    );
    _longitudeController = TextEditingController(
      text: widget.intervention['longitude'].toString(),
    );
    _startDateController = TextEditingController(
      text: widget.intervention['startDate'],
    );
    _endDateController = TextEditingController(
      text: widget.intervention['endDate'],
    );
    _selectedStatus = widget.intervention['status'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Edit Intervention',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D3748),
        ),
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Latitude field
                TextFormField(
                  controller: _latitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Latitude *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.my_location),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
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
                const SizedBox(height: 16),

                // Longitude field
                TextFormField(
                  controller: _longitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Longitude *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.place),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Longitude is required';
                    }
                    final double? lng = double.tryParse(value);
                    if (lng == null || lng < -180 || lng > 180) {
                      return 'Please enter a valid longitude (-180 to 180)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Start Date field
                TextFormField(
                  controller: _startDateController,
                  decoration: const InputDecoration(
                    labelText: 'Start Date *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'YYYY-MM-DD',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(_startDateController.text),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      _startDateController.text =
                          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Start date is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // End Date field
                TextFormField(
                  controller: _endDateController,
                  decoration: const InputDecoration(
                    labelText: 'End Date *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event),
                    hintText: 'YYYY-MM-DD',
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(_endDateController.text),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      _endDateController.text =
                          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'End date is required';
                    }
                    // Validate that end date is after start date
                    if (_startDateController.text.isNotEmpty) {
                      final startDate = DateTime.parse(
                        _startDateController.text,
                      );
                      final endDate = DateTime.parse(value);
                      if (endDate.isBefore(startDate)) {
                        return 'End date must be after start date';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Status dropdown
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.info),
                  ),
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedStatus = newValue;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Status is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Update Intervention'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create the updated intervention data
      final Map<String, dynamic> updatedIntervention = {
        'id': widget.intervention['id'], // Keep the same ID
        'name': _nameController.text.trim(),
        'latitude': double.parse(_latitudeController.text.trim()),
        'longitude': double.parse(_longitudeController.text.trim()),
        'startDate': _startDateController.text.trim(),
        'endDate': _endDateController.text.trim(),
        'status': _selectedStatus,
      };

      // Call the callback function
      widget.onInterventionUpdated(updatedIntervention);

      // Close the dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Intervention "${updatedIntervention['name']}" updated successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
