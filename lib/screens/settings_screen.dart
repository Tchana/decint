import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Sample data for concessionaires
  final List<Map<String, dynamic>> _concessionaires = [
    {
      'id': 'CON-001',
      'name': 'TechFlow Solutions',
      'locations': [
        {'latitude': 45.5017, 'longitude': -73.5673},
        {'latitude': 45.5088, 'longitude': -73.5540},
      ],
      'totalLocations': 2,
      'createdDate': '2024-01-15',
      'attachments': ['contract_techflow.pdf', 'license_certificate.jpg'],
    },
    {
      'id': 'CON-002',
      'name': 'Global Infrastructure Inc.',
      'locations': [
        {'latitude': 45.4215, 'longitude': -75.6972},
        {'latitude': 45.4281, 'longitude': -75.6890},
        {'latitude': 45.4350, 'longitude': -75.6820},
      ],
      'totalLocations': 3,
      'createdDate': '2024-01-10',
      'attachments': [
        'contract_global.pdf',
        'insurance_docs.pdf',
        'registration.docx',
      ],
    },
    {
      'id': 'CON-003',
      'name': 'Metro Services Ltd.',
      'locations': [
        {'latitude': 46.8139, 'longitude': -71.2082},
      ],
      'totalLocations': 1,
      'createdDate': '2024-01-20',
      'attachments': ['business_permit.pdf'],
    },
    {
      'id': 'CON-004',
      'name': 'Urban Development Corp.',
      'locations': [
        {'latitude': 43.6532, 'longitude': -79.3832},
        {'latitude': 43.6482, 'longitude': -79.3762},
        {'latitude': 43.6580, 'longitude': -79.3900},
        {'latitude': 43.6420, 'longitude': -79.3700},
      ],
      'totalLocations': 4,
      'createdDate': '2024-01-05',
      'attachments': ['contract_urban.pdf', 'tax_documents.xlsx'],
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
                  'Concessionaires',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _createConcessionaire,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Concessionaire'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
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
                    'Total Concessionaires',
                    _concessionaires.length.toString(),
                    Icons.business,
                    Colors.purple,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Total Locations',
                    _concessionaires
                        .fold(0, (sum, c) => sum + (c['totalLocations'] as int))
                        .toString(),
                    Icons.location_on,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Active This Month',
                    _concessionaires.length.toString(),
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Average Locations',
                    (_concessionaires.fold(
                              0,
                              (sum, c) => sum + (c['totalLocations'] as int),
                            ) /
                            _concessionaires.length)
                        .toStringAsFixed(1),
                    Icons.analytics,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Concessionaires Table
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
                        'Concessionaires List',
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
                                'Company Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Locations',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Attachments',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Created Date',
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
                          itemCount: _concessionaires.length,
                          itemBuilder: (context, index) {
                            final concessionaire = _concessionaires[index];
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
                                    child: Text(concessionaire['id']),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(concessionaire['name']),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${concessionaire['totalLocations']} locations',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${(concessionaire['attachments'] as List).length} files',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(concessionaire['createdDate']),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: PopupMenuButton<String>(
                                      onSelected: (value) {
                                        _handleAction(value, concessionaire);
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        const PopupMenuItem(
                                          value: 'view',
                                          child: Row(
                                            children: [
                                              Icon(Icons.visibility, size: 16),
                                              SizedBox(width: 8),
                                              Text('View Locations'),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'files',
                                          child: Row(
                                            children: [
                                              Icon(Icons.attach_file, size: 16),
                                              SizedBox(width: 8),
                                              Text('View Files'),
                                            ],
                                          ),
                                        ),
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

  void _createConcessionaire() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _CreateConcessionaireDialog(
          onConcessionaireCreated: (concessionaire) {
            setState(() {
              _concessionaires.add(concessionaire);
            });
          },
        );
      },
    );
  }

  void _handleAction(String action, Map<String, dynamic> concessionaire) {
    switch (action) {
      case 'view':
        _viewLocations(concessionaire);
        break;
      case 'files':
        _viewFiles(concessionaire);
        break;
      case 'edit':
        _editConcessionaire(concessionaire);
        break;
      case 'delete':
        _showDeleteConfirmation(concessionaire);
        break;
    }
  }

  void _viewLocations(Map<String, dynamic> concessionaire) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${concessionaire['name']} - Locations'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...((concessionaire['locations'] as List).asMap().entries.map((
                  entry,
                ) {
                  final index = entry.key + 1;
                  final location = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$index',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Latitude: ${location['latitude']}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Longitude: ${location['longitude']}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _viewFiles(Map<String, dynamic> concessionaire) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final attachments = concessionaire['attachments'] as List<String>;
        return AlertDialog(
          title: Text('${concessionaire['name']} - Attachments'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (attachments.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          'No files attached',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                else
                  ...attachments.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final fileName = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              _getFileIcon(fileName.split('.').last),
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fileName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'File $index',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Placeholder for download/view functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Download $fileName (Feature coming soon)',
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            },
                            icon: const Icon(Icons.download, size: 20),
                            tooltip: 'Download file',
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.attach_file;
    }
  }

  void _editConcessionaire(Map<String, dynamic> concessionaire) {
    // Placeholder for edit functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit functionality coming soon!'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> concessionaire) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Concessionaire'),
          content: Text(
            'Are you sure you want to delete "${concessionaire['name']}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _concessionaires.removeWhere(
                    (item) => item['id'] == concessionaire['id'],
                  );
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Concessionaire deleted successfully'),
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
}

class _CreateConcessionaireDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onConcessionaireCreated;

  const _CreateConcessionaireDialog({required this.onConcessionaireCreated});

  @override
  State<_CreateConcessionaireDialog> createState() =>
      _CreateConcessionaireDialogState();
}

class _CreateConcessionaireDialogState
    extends State<_CreateConcessionaireDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  // List to store multiple locations
  final List<Map<String, TextEditingController>> _locationControllers = [];

  // File attachments
  final List<PlatformFile> _attachedFiles = [];

  // Flag to track if file picker is ready
  bool _isFilePickerReady = false;

  @override
  void initState() {
    super.initState();
    // Add the first location by default
    _addLocation();
    // Initialize file picker
    _initializeFilePicker();
  }

  Future<void> _initializeFilePicker() async {
    try {
      final result = await FilePicker.platform.clearTemporaryFiles();
      // Result can be null, so we don't check it
      if (mounted) {
        setState(() {
          _isFilePickerReady = true;
        });
      }
    } catch (e) {
      // If initialization fails, set ready to true anyway
      // as the picker might still work
      if (mounted) {
        setState(() {
          _isFilePickerReady = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    // Dispose all location controllers
    for (var controllers in _locationControllers) {
      controllers['latitude']!.dispose();
      controllers['longitude']!.dispose();
    }
    super.dispose();
  }

  void _addLocation() {
    setState(() {
      _locationControllers.add({
        'latitude': TextEditingController(),
        'longitude': TextEditingController(),
      });
    });
  }

  void _removeLocation(int index) {
    setState(() {
      // Dispose controllers before removing
      _locationControllers[index]['latitude']!.dispose();
      _locationControllers[index]['longitude']!.dispose();
      _locationControllers.removeAt(index);
    });
  }

  Widget _buildFileChip(PlatformFile file) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFileIcon(file.extension ?? ''),
            size: 16,
            color: Colors.orange,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              file.name,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.orange,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => _removeFile(file),
            child: const Icon(Icons.close, size: 14, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      _attachedFiles.remove(file);
    });
  }

  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.attach_file;
    }
  }

  Future<void> _pickFiles() async {
    if (!_isFilePickerReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File picker is not ready yet. Please wait a moment.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
        withData: false, // Don't load file data to avoid memory issues
        withReadStream: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _attachedFiles.addAll(result.files);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${result.files.length} file(s) selected successfully',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        // User cancelled or no files selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No files selected'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      // More specific error handling
      String errorMessage = 'Error picking files';

      if (e.toString().contains('LateInitializationError')) {
        errorMessage = 'File picker not initialized. Please restart the app.';
      } else if (e.toString().contains('PlatformException')) {
        errorMessage =
            'Permission denied. Please check file access permissions.';
      } else if (e.toString().contains('MissingPluginException')) {
        errorMessage = 'File picker plugin not available on this platform.';
      } else {
        errorMessage = 'Unexpected error: Please try again later.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _pickFiles,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.business, color: Colors.purple),
          SizedBox(width: 12),
          Text(
            'Add New Concessionaire',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 600,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business, color: Colors.purple),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Company name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Locations section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Locations *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _addLocation,
                      icon: const Icon(Icons.add_location, size: 16),
                      label: const Text(
                        'Add Location',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Dynamic location fields
                ...List.generate(_locationControllers.length, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[50],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            if (_locationControllers.length > 1)
                              IconButton(
                                onPressed: () => _removeLocation(index),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:
                                    _locationControllers[index]['latitude'],
                                decoration: const InputDecoration(
                                  labelText: 'Latitude',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.my_location, size: 20),
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Required';
                                  }
                                  final double? lat = double.tryParse(value);
                                  if (lat == null || lat < -90 || lat > 90) {
                                    return 'Invalid latitude';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller:
                                    _locationControllers[index]['longitude'],
                                decoration: const InputDecoration(
                                  labelText: 'Longitude',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.place, size: 20),
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Required';
                                  }
                                  final double? lng = double.tryParse(value);
                                  if (lng == null || lng < -180 || lng > 180) {
                                    return 'Invalid longitude';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                if (_locationControllers.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red[50],
                    ),
                    child: const Text(
                      'At least one location is required',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 20),

                // File Attachments section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Documents & Files',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isFilePickerReady ? _pickFiles : null,
                      icon: Icon(
                        Icons.attach_file,
                        size: 16,
                        color: _isFilePickerReady ? null : Colors.grey,
                      ),
                      label: Text(
                        _isFilePickerReady ? 'Add Files' : 'Loading...',
                        style: const TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // File attachments display
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 80),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[50],
                  ),
                  child: _attachedFiles.isEmpty
                      ? Column(
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 32,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No files attached',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _attachedFiles
                              .map((file) => _buildFileChip(file))
                              .toList(),
                        ),
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
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Create Concessionaire'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _locationControllers.isNotEmpty) {
      // Generate a unique ID
      final int nextId = DateTime.now().millisecondsSinceEpoch % 1000;
      final String concessionaireId =
          'CON-${nextId.toString().padLeft(3, '0')}';

      // Create locations list
      final List<Map<String, double>> locations = _locationControllers.map((
        controllers,
      ) {
        return {
          'latitude': double.parse(controllers['latitude']!.text.trim()),
          'longitude': double.parse(controllers['longitude']!.text.trim()),
        };
      }).toList();

      // Create the concessionaire data
      final Map<String, dynamic> newConcessionaire = {
        'id': concessionaireId,
        'name': _nameController.text.trim(),
        'locations': locations,
        'totalLocations': locations.length,
        'createdDate': DateTime.now().toIso8601String().split(
          'T',
        )[0], // YYYY-MM-DD format
        'attachments': _attachedFiles.map((f) => f.name).toList(),
      };

      // Call the callback function
      widget.onConcessionaireCreated(newConcessionaire);

      // Close the dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Concessionaire "${newConcessionaire['name']}" created with ${locations.length} location(s) and ${_attachedFiles.length} file(s)!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
