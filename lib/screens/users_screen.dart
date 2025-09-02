import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // Profile types
  final List<String> _profileTypes = [
    'Admin',
    'Maitre d\'ouvrage',
    'Concessionaire',
    'CTD',
    'BET',
    'Entreprise de travaux',
    'Lecteur',
  ];

  // Sample data for users
  final List<Map<String, dynamic>> _users = [
    {
      'id': 'USR-001',
      'name': 'Jean Dupont',
      'email': 'jean.dupont@admin.com',
      'profileType': 'Admin',
      'status': 'Active',
      'createdDate': '2024-01-15',
      'lastLogin': '2025-01-21',
    },
    {
      'id': 'USR-002',
      'name': 'Marie Martin',
      'email': 'marie.martin@maitredouvrage.com',
      'profileType': 'Maitre d\'ouvrage',
      'status': 'Active',
      'createdDate': '2024-01-10',
      'lastLogin': '2025-01-20',
    },
    {
      'id': 'USR-003',
      'name': 'Pierre Bernard',
      'email': 'pierre.bernard@concessionaire.com',
      'profileType': 'Concessionaire',
      'status': 'Inactive',
      'createdDate': '2024-01-20',
      'lastLogin': '2025-01-15',
    },
    {
      'id': 'USR-004',
      'name': 'Sophie Leroy',
      'email': 'sophie.leroy@ctd.com',
      'profileType': 'CTD',
      'status': 'Active',
      'createdDate': '2024-01-05',
      'lastLogin': '2025-01-21',
    },
    {
      'id': 'USR-005',
      'name': 'Michel Dubois',
      'email': 'michel.dubois@bet.com',
      'profileType': 'BET',
      'status': 'Active',
      'createdDate': '2024-01-25',
      'lastLogin': '2025-01-19',
    },
    {
      'id': 'USR-006',
      'name': 'Isabelle Moreau',
      'email': 'isabelle.moreau@entreprise.com',
      'profileType': 'Entreprise de travaux',
      'status': 'Active',
      'createdDate': '2024-01-12',
      'lastLogin': '2025-01-18',
    },
    {
      'id': 'USR-007',
      'name': 'Laurent Petit',
      'email': 'laurent.petit@lecteur.com',
      'profileType': 'Lecteur',
      'status': 'Inactive',
      'createdDate': '2024-01-08',
      'lastLogin': '2025-01-10',
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
                  'Users Management',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _createUser,
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add User'),
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
                    'Total Users',
                    _users.length.toString(),
                    Icons.people,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Active Users',
                    _users
                        .where((u) => u['status'] == 'Active')
                        .length
                        .toString(),
                    Icons.person_outline,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Inactive Users',
                    _users
                        .where((u) => u['status'] == 'Inactive')
                        .length
                        .toString(),
                    Icons.person_off,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Profile Types',
                    _profileTypes.length.toString(),
                    Icons.badge,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Users Table
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
                        'Users List',
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
                              flex: 3,
                              child: Text(
                                'Email',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Profile Type',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Status',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Last Login',
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
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
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
                                  Expanded(flex: 2, child: Text(user['id'])),
                                  Expanded(flex: 3, child: Text(user['name'])),
                                  Expanded(flex: 3, child: Text(user['email'])),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getProfileTypeColor(
                                          user['profileType'],
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        user['profileType'],
                                        style: TextStyle(
                                          color: _getProfileTypeColor(
                                            user['profileType'],
                                          ),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(
                                          user['status'],
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        user['status'],
                                        style: TextStyle(
                                          color: _getStatusColor(
                                            user['status'],
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(user['lastLogin']),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: PopupMenuButton<String>(
                                      onSelected: (value) {
                                        _handleAction(value, user);
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
                                          value: 'status',
                                          child: Row(
                                            children: [
                                              Icon(Icons.swap_horiz, size: 16),
                                              SizedBox(width: 8),
                                              Text('Toggle Status'),
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

  Color _getProfileTypeColor(String profileType) {
    switch (profileType) {
      case 'Admin':
        return Colors.red;
      case 'Maitre d\'ouvrage':
        return Colors.purple;
      case 'Concessionaire':
        return Colors.orange;
      case 'CTD':
        return Colors.blue;
      case 'BET':
        return Colors.green;
      case 'Entreprise de travaux':
        return Colors.brown;
      case 'Lecteur':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _createUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _UserDialog(
          title: 'Add New User',
          profileTypes: _profileTypes,
          onUserSaved: (user) {
            setState(() {
              _users.add(user);
            });
          },
        );
      },
    );
  }

  void _handleAction(String action, Map<String, dynamic> user) {
    switch (action) {
      case 'edit':
        _editUser(user);
        break;
      case 'status':
        _toggleUserStatus(user);
        break;
      case 'delete':
        _showDeleteConfirmation(user);
        break;
    }
  }

  void _editUser(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _UserDialog(
          title: 'Edit User',
          profileTypes: _profileTypes,
          existingUser: user,
          onUserSaved: (updatedUser) {
            setState(() {
              final index = _users.indexWhere(
                (item) => item['id'] == user['id'],
              );
              if (index != -1) {
                _users[index] = updatedUser;
              }
            });
          },
        );
      },
    );
  }

  void _toggleUserStatus(Map<String, dynamic> user) {
    setState(() {
      final index = _users.indexWhere((item) => item['id'] == user['id']);
      if (index != -1) {
        _users[index]['status'] = _users[index]['status'] == 'Active'
            ? 'Inactive'
            : 'Active';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'User ${user['name']} status changed to ${_users.firstWhere((u) => u['id'] == user['id'])['status']}',
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text(
            'Are you sure you want to delete user "${user['name']}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _users.removeWhere((item) => item['id'] == user['id']);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User deleted successfully'),
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

class _UserDialog extends StatefulWidget {
  final String title;
  final List<String> profileTypes;
  final Map<String, dynamic>? existingUser;
  final Function(Map<String, dynamic>) onUserSaved;

  const _UserDialog({
    required this.title,
    required this.profileTypes,
    required this.onUserSaved,
    this.existingUser,
  });

  @override
  State<_UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<_UserDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late String _selectedProfileType;
  late String _selectedStatus;

  final List<String> _statusOptions = ['Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data if editing
    _nameController = TextEditingController(
      text: widget.existingUser?['name'] ?? '',
    );
    _emailController = TextEditingController(
      text: widget.existingUser?['email'] ?? '',
    );
    _selectedProfileType =
        widget.existingUser?['profileType'] ?? widget.profileTypes.first;
    _selectedStatus = widget.existingUser?['status'] ?? 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingUser != null;

    return AlertDialog(
      title: Row(
        children: [
          Icon(isEditing ? Icons.edit : Icons.person_add, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Profile Type dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedProfileType,
                  decoration: const InputDecoration(
                    labelText: 'Profile Type *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge, color: Colors.blue),
                  ),
                  items: widget.profileTypes.map((String profileType) {
                    return DropdownMenuItem<String>(
                      value: profileType,
                      child: Text(profileType),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedProfileType = newValue;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Profile type is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Status dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.toggle_on, color: Colors.blue),
                  ),
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: status == 'Active'
                                  ? Colors.green
                                  : Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(status),
                        ],
                      ),
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
          child: Text(isEditing ? 'Update User' : 'Create User'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final isEditing = widget.existingUser != null;

      // Generate a unique ID if creating new user
      final String userId = isEditing
          ? widget.existingUser!['id']
          : 'USR-${(DateTime.now().millisecondsSinceEpoch % 1000).toString().padLeft(3, '0')}';

      // Create the user data
      final Map<String, dynamic> userData = {
        'id': userId,
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'profileType': _selectedProfileType,
        'status': _selectedStatus,
        'createdDate': isEditing
            ? widget.existingUser!['createdDate']
            : DateTime.now().toIso8601String().split('T')[0],
        'lastLogin': isEditing
            ? widget.existingUser!['lastLogin']
            : DateTime.now().toIso8601String().split('T')[0],
      };

      // Call the callback function
      widget.onUserSaved(userData);

      // Close the dialog
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User "${userData['name']}" ${isEditing ? 'updated' : 'created'} successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
