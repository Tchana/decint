# User Guide - DECINT Admin Panel

## 🚀 Getting Started

Welcome to DECINT, a comprehensive Flutter admin panel for intervention management, user administration, and concessionaire oversight. This guide will help you navigate and use all the features effectively.

## 📊 Dashboard Overview

When you first open DECINT, you'll see the Dashboard screen which provides:
- **Quick Statistics**: Overview of total interventions, users, and activities
- **Recent Activity**: Latest system actions and updates
- **Quick Access**: Fast navigation to commonly used features

### Navigation Menu
The left sidebar contains five main sections:
1. **Dashboard** 📊 - Overview and statistics
2. **Users** 👥 - User management
3. **Interventions** 🚨 - Intervention tracking
4. **History** 📚 - Action history and reporting
5. **Concessionaires** 🏢 - Company management

## 👥 User Management

### Viewing Users
- Navigate to the **Users** section from the sidebar
- View all users in a comprehensive table showing:
  - User ID and name
  - Email address
  - Profile type with color-coded badges
  - Status (Active/Inactive)
  - Last login date

### Creating a New User
1. Click the **"Add User"** button in the top-right corner
2. Fill in the required information:
   - **Full Name**: Enter the user's complete name
   - **Email Address**: Must be a valid email format
   - **Profile Type**: Choose from 7 available types:
     - **Admin** 🔴 - Full system access
     - **Maître d'ouvrage** 🟣 - Project owner
     - **Concessionaire** 🟠 - Service provider
     - **CTD** 🔵 - Technical control
     - **BET** 🟢 - Engineering office
     - **Entreprise de travaux** 🟤 - Construction company
     - **Lecteur** ⚫ - Read-only access
   - **Status**: Set as Active or Inactive
3. Click **"Create User"** to save

### Managing Existing Users
- **Edit User**: Click the menu (⋮) next to any user and select "Edit"
- **Toggle Status**: Quickly switch between Active/Inactive status
- **Delete User**: Remove users (requires confirmation)

## 🚨 Intervention Management

### Understanding Interventions
Interventions are field operations with specific locations and time periods. The system prevents conflicts by checking for overlapping operations.

### Creating an Intervention
1. Navigate to the **Interventions** section
2. Click **"Create Intervention"** button
3. Fill in the required fields:
   - **Name**: Descriptive name for the intervention
   - **Latitude**: GPS coordinate (-90 to 90)
   - **Longitude**: GPS coordinate (-180 to 180)
   - **Start Date**: When the intervention begins
   - **End Date**: When the intervention ends
   - **Status**: Choose from French status options:
     - **en cours** 🟢 - Currently ongoing
     - **en pause** 🟡 - Temporarily paused
     - **terminée** 🔴 - Completed

### Conflict Detection
The system automatically prevents conflicts by checking:
- **Location Proximity**: Within ~11 meters (0.0001 degrees)
- **Date Overlap**: Overlapping time periods
- **Status**: Only "en cours" (ongoing) interventions create conflicts

If a conflict is detected, you'll see an alert: *"There is an ongoing intervention"*

### Editing Interventions
1. Click the edit button (✏️) next to any intervention
2. Modify the fields as needed
3. The system will check for conflicts with the updated information
4. Save your changes

## 📚 History & Reporting

### Viewing History
The History section shows all intervention activities in an accordion-style interface:
- **Created Interventions** 🟢 - Successfully created
- **Updated Interventions** 🟠 - Modified interventions
- **Conflicts** 🔴 - Prevented due to conflicts

### Generating Reports
Each history entry has four report types available:

#### 1. Progress Report 📈
- **Subject**: Brief description
- **Description**: Detailed progress information
- **File Attachments**: Supporting documents

#### 2. Incident Report ⚠️
- **Subject**: Issue summary
- **Description**: Detailed incident information
- **File Attachments**: Evidence or documentation

#### 3. Completion Report ✅
- **Multiple File Attachments**: Final deliverables and documentation
- No text fields required

#### 4. General Report 📄
- **Subject**: Report topic
- **Description**: General information
- **File Attachments**: Any supporting files

### Creating Reports
1. Expand any history entry by clicking on it
2. Click one of the four report buttons at the bottom
3. Fill in the required information
4. Attach files by clicking **"Add Files"**
5. Submit the report

The report will automatically appear within the accordion entry.

## 🏢 Concessionaire Management

### Understanding Concessionaires
Concessionaires are companies or organizations that can have multiple operational locations and associated documents.

### Creating a Concessionaire
1. Navigate to the **Concessionaires** section
2. Click **"Add Concessionaire"** button
3. Fill in the information:
   - **Company Name**: Official business name
   - **Locations**: Add one or more GPS coordinates
     - Each location needs latitude and longitude
     - Use **"Add Location"** to add multiple sites
     - Use the delete button (🗑️) to remove locations
   - **Documents**: Upload relevant files
     - Contracts, licenses, permits, etc.
     - Multiple file formats supported

### Managing Concessionaires
From the actions menu (⋮) for each concessionaire:
- **View Locations**: See all GPS coordinates on a detailed list
- **View Files**: Browse and download attached documents
- **Edit**: Modify company information (coming soon)
- **Delete**: Remove the concessionaire (requires confirmation)

## 📎 File Management

### Supported File Types
The system supports various file formats:
- **Documents**: PDF, DOC, DOCX, TXT
- **Spreadsheets**: XLS, XLSX
- **Images**: JPG, JPEG, PNG, GIF
- **Other**: Any file type can be uploaded

### File Attachment Process
1. Click **"Add Files"** or **"Attach Files"** button
2. Select one or multiple files from your device
3. Files will appear as colored chips showing:
   - File name
   - File type icon
   - Remove option (×)
4. Submit your form to save the attachments

### File Management Tips
- **File Size**: Keep files reasonable in size for better performance
- **File Names**: Use descriptive names for easy identification
- **Organization**: Group related files together in reports
- **Security**: Only upload business-related, appropriate content

## 🔍 Search and Filtering

### Finding Information
- **Tables**: Use browser search (Ctrl+F) to find specific entries
- **History**: Expand entries to see detailed information
- **Status Filters**: Look for color-coded status indicators
- **Date Sorting**: Items are typically sorted by most recent first

## ⚙️ Best Practices

### Data Entry
- **Accuracy**: Double-check GPS coordinates before submission
- **Completeness**: Fill all required fields (marked with *)
- **Consistency**: Use consistent naming conventions
- **Validation**: Pay attention to validation messages

### File Management
- **Naming**: Use descriptive, consistent file names
- **Format**: Choose appropriate file formats for content type
- **Size**: Optimize file sizes for better performance
- **Organization**: Group related files logically

### Conflict Prevention
- **Planning**: Check existing interventions before creating new ones
- **Timing**: Plan intervention schedules to avoid overlaps
- **Location**: Verify GPS coordinates are accurate
- **Status**: Update intervention status promptly when completed

## 🚨 Troubleshooting

### Common Issues

#### File Upload Problems
- **Error Message**: "File picker not ready"
  - **Solution**: Wait a moment and try again
- **LateInitializationError**: 
  - **Solution**: Restart the application
- **Permission Denied**: 
  - **Solution**: Check file access permissions

#### Form Validation Errors
- **Invalid Email**: Ensure email follows format (user@domain.com)
- **Invalid GPS**: Check latitude (-90 to 90) and longitude (-180 to 180)
- **Date Issues**: Ensure start date is before end date

#### Conflict Detection
- **Unexpected Conflicts**: 
  - Check for nearby existing interventions
  - Verify date ranges don't overlap
  - Ensure coordinates are accurate

### Getting Help
- Check error messages for specific guidance
- Use the retry functionality when available
- Verify your input data meets the requirements
- Contact system administrator for persistent issues

## 🎯 Tips for Efficient Use

### Workflow Optimization
1. **Start with Dashboard**: Get an overview before diving into details
2. **Batch Operations**: Create multiple similar items in sequence
3. **Regular Updates**: Keep intervention statuses current
4. **Document Everything**: Use reports to maintain detailed records

### Data Quality
- **Standardization**: Use consistent naming and formatting
- **Regular Reviews**: Periodically check and update information
- **Backup**: Ensure important files are properly attached
- **Verification**: Double-check critical information before submission

### System Performance
- **File Sizes**: Keep attachments reasonably sized
- **Batch Uploads**: Upload multiple files at once when possible
- **Regular Cleanup**: Remove unnecessary or outdated information

---

This user guide covers all major features of the DECINT admin panel. For technical support or additional questions, please contact your system administrator.