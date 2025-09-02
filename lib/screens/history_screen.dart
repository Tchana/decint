import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'analytics_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final historyList = AnalyticsScreen.historyList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Intervention History',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${historyList.length} entries',
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w600,
                    ),
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
                    'Total Actions',
                    historyList.length.toString(),
                    Icons.history,
                    Colors.indigo,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Created',
                    historyList
                        .where((h) => h['action'] == 'CREATED')
                        .length
                        .toString(),
                    Icons.add_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Conflicts',
                    historyList
                        .where(
                          (h) =>
                              h['action'] == 'CONFLICT' ||
                              h['action'] == 'EDIT_CONFLICT',
                        )
                        .length
                        .toString(),
                    Icons.warning,
                    Colors.red,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Updated',
                    historyList
                        .where((h) => h['action'] == 'UPDATED')
                        .length
                        .toString(),
                    Icons.edit,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // History List
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
                        'Action History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: historyList.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.history,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No history yet',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Create or edit interventions to see history',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: historyList.length,
                                itemBuilder: (context, index) {
                                  final historyEntry =
                                      historyList[historyList.length -
                                          1 -
                                          index]; // Reverse order
                                  return _buildHistoryAccordion(
                                    historyEntry,
                                    index,
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

  Widget _buildHistoryAccordion(Map<String, dynamic> historyEntry, int index) {
    final action = historyEntry['action'] as String;
    final timestamp = DateTime.parse(historyEntry['timestamp']);
    final intervention = historyEntry['intervention'] as Map<String, dynamic>;

    Color actionColor;
    IconData actionIcon;
    String actionTitle;

    switch (action) {
      case 'CREATED':
        actionColor = Colors.green;
        actionIcon = Icons.add_circle;
        actionTitle = 'Intervention Created';
        break;
      case 'UPDATED':
        actionColor = Colors.orange;
        actionIcon = Icons.edit;
        actionTitle = 'Intervention Updated';
        break;
      case 'CONFLICT':
        actionColor = Colors.red;
        actionIcon = Icons.warning;
        actionTitle = 'Creation Conflict';
        break;
      case 'EDIT_CONFLICT':
        actionColor = Colors.red;
        actionIcon = Icons.warning;
        actionTitle = 'Edit Conflict';
        break;
      default:
        actionColor = Colors.grey;
        actionIcon = Icons.info;
        actionTitle = 'Unknown Action';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: actionColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(actionIcon, color: actionColor, size: 20),
        ),
        title: Text(
          actionTitle,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              intervention['name'] ?? 'Unnamed Intervention',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            Text(
              _formatTimestamp(timestamp),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Intervention ID', intervention['id'] ?? 'N/A'),
                _buildDetailRow('Name', intervention['name'] ?? 'N/A'),
                _buildDetailRow(
                  'Latitude',
                  intervention['latitude']?.toString() ?? 'N/A',
                ),
                _buildDetailRow(
                  'Longitude',
                  intervention['longitude']?.toString() ?? 'N/A',
                ),
                _buildDetailRow(
                  'Start Date',
                  intervention['startDate'] ?? 'N/A',
                ),
                _buildDetailRow('End Date', intervention['endDate'] ?? 'N/A'),
                _buildDetailRow('Status', intervention['status'] ?? 'N/A'),

                if (action == 'CONFLICT' || action == 'EDIT_CONFLICT') ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Conflict Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(historyEntry['reason'] ?? 'No reason provided'),
                        if (historyEntry['conflictWith'] != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Conflicted with: ${historyEntry['conflictWith']['name']} (${historyEntry['conflictWith']['id']})',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],

                if (action == 'UPDATED' &&
                    historyEntry['originalIntervention'] != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Previous Values',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Previous Name',
                          historyEntry['originalIntervention']['name'] ?? 'N/A',
                        ),
                        _buildDetailRow(
                          'Previous Status',
                          historyEntry['originalIntervention']['status'] ??
                              'N/A',
                        ),
                      ],
                    ),
                  ),
                ],

                // Action Buttons
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      'Progress Report',
                      Icons.trending_up,
                      Colors.blue,
                      () => _showProgressReport(historyEntry),
                    ),
                    _buildActionButton(
                      'Incident Report',
                      Icons.warning,
                      Colors.red,
                      () => _showIncidentReport(historyEntry),
                    ),
                    _buildActionButton(
                      'Completion Report',
                      Icons.check_circle,
                      Colors.green,
                      () => _showCompletionReport(historyEntry),
                    ),
                    _buildActionButton(
                      'General Report',
                      Icons.description,
                      Colors.purple,
                      () => _showGeneralReport(historyEntry),
                    ),
                  ],
                ),

                // Display submitted reports
                const SizedBox(height: 16),
                _buildReportsSection(historyEntry),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildReportsSection(Map<String, dynamic> historyEntry) {
    final historyTimestamp = historyEntry['timestamp'] as String;
    final reports = AnalyticsScreen.historyReports[historyTimestamp] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (reports.isNotEmpty) ...[
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Submitted Reports (${reports.length})',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 12),
          ...reports.map((report) => _buildReportCard(report)).toList(),
        ] else ...[
          // Show a placeholder when no reports exist
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'No reports submitted yet',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    Color reportColor = _getReportColor(report['type']);
    IconData reportIcon = _getReportIcon(report['type']);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: reportColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(reportIcon, color: reportColor, size: 16),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    report['type'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: reportColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  _formatTimestamp(DateTime.parse(report['timestamp'])),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            if (report['subject'] != null) ...[
              const SizedBox(height: 8),
              Text(
                'Subject: ${report['subject']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
            if (report['description'] != null) ...[
              const SizedBox(height: 4),
              Text(
                report['description'],
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (report['attachedFiles'] != null &&
                (report['attachedFiles'] as List).isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: (report['attachedFiles'] as List<String>)
                    .map(
                      (fileName) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          fileName,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            if (report['completionFiles'] != null &&
                (report['completionFiles'] as List).isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: (report['completionFiles'] as List<String>)
                    .map(
                      (fileName) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          fileName,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getReportColor(String reportType) {
    switch (reportType) {
      case 'Progress Report':
        return Colors.blue;
      case 'Incident Report':
        return Colors.red;
      case 'Completion Report':
        return Colors.green;
      case 'General Report':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getReportIcon(String reportType) {
    switch (reportType) {
      case 'Progress Report':
        return Icons.trending_up;
      case 'Incident Report':
        return Icons.warning;
      case 'Completion Report':
        return Icons.check_circle;
      case 'General Report':
        return Icons.description;
      default:
        return Icons.info;
    }
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 2,
      ),
    );
  }

  void _showProgressReport(Map<String, dynamic> historyEntry) {
    showDialog(
      context: context,
      builder: (context) => _ReportDialog(
        title: 'Progress Report',
        icon: Icons.trending_up,
        color: Colors.blue,
        historyEntry: historyEntry,
        showSubject: true,
        showDescription: true,
        showMultipleFiles: false,
        onReportSubmitted: () {
          setState(() {});
        },
      ),
    );
  }

  void _showIncidentReport(Map<String, dynamic> historyEntry) {
    showDialog(
      context: context,
      builder: (context) => _ReportDialog(
        title: 'Incident Report',
        icon: Icons.warning,
        color: Colors.red,
        historyEntry: historyEntry,
        showSubject: true,
        showDescription: true,
        showMultipleFiles: false,
        onReportSubmitted: () {
          setState(() {});
        },
      ),
    );
  }

  void _showCompletionReport(Map<String, dynamic> historyEntry) {
    showDialog(
      context: context,
      builder: (context) => _ReportDialog(
        title: 'Completion Report',
        icon: Icons.check_circle,
        color: Colors.green,
        historyEntry: historyEntry,
        showSubject: false,
        showDescription: false,
        showMultipleFiles: true,
        onReportSubmitted: () {
          setState(() {});
        },
      ),
    );
  }

  void _showGeneralReport(Map<String, dynamic> historyEntry) {
    showDialog(
      context: context,
      builder: (context) => _ReportDialog(
        title: 'General Report',
        icon: Icons.description,
        color: Colors.purple,
        historyEntry: historyEntry,
        showSubject: true,
        showDescription: true,
        showMultipleFiles: false,
        onReportSubmitted: () {
          setState(() {});
        },
      ),
    );
  }
}

class _ReportDialog extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Map<String, dynamic> historyEntry;
  final bool showSubject;
  final bool showDescription;
  final bool showMultipleFiles;
  final VoidCallback onReportSubmitted;

  const _ReportDialog({
    required this.title,
    required this.icon,
    required this.color,
    required this.historyEntry,
    required this.showSubject,
    required this.showDescription,
    required this.showMultipleFiles,
    required this.onReportSubmitted,
  });

  @override
  State<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<_ReportDialog> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  // File attachments
  List<PlatformFile> _attachedFiles = [];
  List<PlatformFile> _completionFiles = [];

  // Flag to track if file picker is ready
  bool _isFilePickerReady = false;

  @override
  void initState() {
    super.initState();
    _initializeFilePicker();
  }

  Future<void> _initializeFilePicker() async {
    try {
      // Initialize file picker by attempting to clear temporary files
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
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(widget.icon, color: widget.color, size: 24),
          ),
          const SizedBox(width: 12),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.color,
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
                // Intervention Info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intervention Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Name: ${widget.historyEntry['intervention']['name']}',
                      ),
                      Text('ID: ${widget.historyEntry['intervention']['id']}'),
                      Text(
                        'Status: ${widget.historyEntry['intervention']['status']}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Subject field (for progress, incident, and general reports)
                if (widget.showSubject) ...[
                  TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject *',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.subject, color: widget.color),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Subject is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // File attachment for subject field
                  _buildFileAttachmentSection(
                    'Subject Attachments',
                    _attachedFiles,
                    () => _pickFiles(false),
                  ),
                  const SizedBox(height: 16),
                ],

                // Description field (for progress, incident, and general reports)
                if (widget.showDescription) ...[
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description *',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description, color: widget.color),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // File attachment for description field
                  _buildFileAttachmentSection(
                    'Description Attachments',
                    _attachedFiles,
                    () => _pickFiles(false),
                  ),
                  const SizedBox(height: 16),
                ],

                // Multiple files for completion report
                if (widget.showMultipleFiles) ...[
                  _buildFileAttachmentSection(
                    'Completion Documents *',
                    _completionFiles,
                    () => _pickFiles(true),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please attach completion documents, certificates, or relevant files.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
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
          onPressed: _submitReport,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            foregroundColor: Colors.white,
          ),
          child: const Text('Submit Report'),
        ),
      ],
    );
  }

  Widget _buildFileAttachmentSection(
    String title,
    List<PlatformFile> files,
    VoidCallback onPickFiles,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            TextButton.icon(
              onPressed: _isFilePickerReady ? onPickFiles : null,
              icon: Icon(
                Icons.attach_file,
                size: 16,
                color: _isFilePickerReady ? null : Colors.grey,
              ),
              label: Text(
                _isFilePickerReady ? 'Add Files' : 'Loading...',
                style: const TextStyle(fontSize: 12),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 80),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[50],
          ),
          child: files.isEmpty
              ? Column(
                  children: [
                    Icon(Icons.cloud_upload, size: 32, color: Colors.grey[400]),
                    const SizedBox(height: 8),
                    Text(
                      'No files attached',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: files.map((file) => _buildFileChip(file)).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildFileChip(PlatformFile file) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getFileIcon(file.extension ?? ''),
            size: 16,
            color: widget.color,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              file.name,
              style: TextStyle(
                fontSize: 12,
                color: widget.color,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => _removeFile(file),
            child: Icon(Icons.close, size: 14, color: widget.color),
          ),
        ],
      ),
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

  void _removeFile(PlatformFile file) {
    setState(() {
      _attachedFiles.remove(file);
      _completionFiles.remove(file);
    });
  }

  Future<void> _pickFiles(bool isCompletionFiles) async {
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
          if (isCompletionFiles) {
            _completionFiles.addAll(result.files);
          } else {
            _attachedFiles.addAll(result.files);
          }
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
              onPressed: () => _pickFiles(isCompletionFiles),
            ),
          ),
        );
      }
    }
  }

  void _submitReport() {
    if (widget.showMultipleFiles && _completionFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please attach at least one completion document'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Create report data
      final reportData = {
        'type': widget.title,
        'interventionId': widget.historyEntry['intervention']['id'],
        'interventionName': widget.historyEntry['intervention']['name'],
        'timestamp': DateTime.now().toIso8601String(),
        if (widget.showSubject) 'subject': _subjectController.text.trim(),
        if (widget.showDescription)
          'description': _descriptionController.text.trim(),
        'attachedFiles': _attachedFiles.map((f) => f.name).toList(),
        if (widget.showMultipleFiles)
          'completionFiles': _completionFiles.map((f) => f.name).toList(),
      };

      // Add report to the history entry
      final historyTimestamp = widget.historyEntry['timestamp'] as String;
      AnalyticsScreen.addReportToHistory(historyTimestamp, reportData);

      // Debug: Check if report was added
      final updatedReports =
          AnalyticsScreen.historyReports[historyTimestamp] ?? [];
      print('Reports after addition: ${updatedReports.length}'); // Debug line

      // Close the dialog first
      Navigator.of(context).pop();

      // Trigger UI refresh using the callback
      widget.onReportSubmitted();

      // Show success message with report count
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${widget.title} submitted successfully! Total reports: ${updatedReports.length}',
          ),
          backgroundColor: widget.color,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
