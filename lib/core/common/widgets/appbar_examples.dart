import 'package:dermaininstitute/core/common/widgets/custom_appbar.dart';
import 'package:dermaininstitute/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Example screen demonstrating all three CustomAppBar types
/// This file shows how to use the CustomAppBar widget in different scenarios
class AppBarExamplesScreen extends StatelessWidget {
  const AppBarExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9FAFB),
          elevation: 0,
          title: const Text('AppBar Examples'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Logo + Avatar'),
              Tab(text: 'Back + Avatar'),
              Tab(text: 'Back + Action'),
            ],
          ),
        ),
        body: TabBarView(
          children: [_buildExample1(), _buildExample2(), _buildExample3()],
        ),
      ),
    );
  }

  /// Example 1: Logo with Avatar and Connection Status
  Widget _buildExample1() {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),

      // Type 1: Logo on left, Avatar with connection status on right
      appBar: AppBarHelper.logoWithAvatar(
        showConnectionStatus: true,
        connectionStatusColor: const Color(0xFF2A7900), // Green for online
      ),

      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Type 1: Logo with Avatar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Features:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text('• Company logo on the left'),
              Text('• User avatar on the right'),
              Text('• Connection status indicator dot'),
              Text('• Perfect for dashboard/home screens'),
              SizedBox(height: 30),
              Text(
                'Code Example:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'appBar: AppBarHelper.logoWithAvatar(\n'
                    '  logoImagePath: ImagePath.ivLogo,\n'
                    '  connectionStatusColor: Color(0xFF2A7900),\n'
                    '),',
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Example 2: Back Arrow with Title and Avatar
  Widget _buildExample2() {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),

      // Type 2: Back button + title on left, Avatar on right
      appBar: AppBarHelper.backWithAvatar(
        title: 'Protocols',
        onBackPressed: () => Get.back(),
        connectionStatusColor: const Color(0xFFD3D3D3), // Gray for offline
      ),

      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Type 2: Back with Avatar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Features:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text('• Back arrow for navigation'),
              Text('• Page title'),
              Text('• User avatar with status'),
              Text('• Perfect for detail/settings screens'),
              SizedBox(height: 30),
              Text(
                'Code Example:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'appBar: AppBarHelper.backWithAvatar(\n'
                    '  title: \'Protocols\',\n'
                    '  onBackPressed: () => Get.back(),\n'
                    '),',
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Example 3: Back Arrow with Title and Action Button
  Widget _buildExample3() {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),

      // Type 3: Back button + title on left, Action button on right
      appBar: AppBarHelper.backWithAction(
        title: 'Reports',
        onBackPressed: () => Get.back(),
        actionText: 'New Log',
        actionIcon: IconPath.icEdit, // You can use any icon from IconPath
        onActionPressed: () {
          // Handle action button press
          Get.snackbar('Action', 'New Log button pressed!');
        },
      ),

      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Type 3: Back with Action',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Features:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text('• Back arrow for navigation'),
              Text('• Page title'),
              Text('• Custom action button'),
              Text('• Icon + text in action button'),
              Text('• Perfect for list/management screens'),
              SizedBox(height: 30),
              Text(
                'Code Example:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'appBar: AppBarHelper.backWithAction(\n'
                    '  title: \'Reports\',\n'
                    '  actionText: \'New Log\',\n'
                    '  actionIcon: IconPath.icEdit,\n'
                    '  onActionPressed: () {\n'
                    '    // Handle action\n'
                    '  },\n'
                    '),',
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Advanced usage examples showing CustomAppBar widget directly
class AdvancedAppBarExamplesScreen extends StatelessWidget {
  const AdvancedAppBarExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),

      // Advanced CustomAppBar usage with custom widgets
      appBar: CustomAppBar(
        type: AppBarType.backWithAction,
        title: 'Advanced Example',
        onBackPressed: () => Get.back(),

        // Custom action widget instead of default button
        actionWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => Get.snackbar('Search', 'Search pressed!'),
              icon: const Icon(Icons.search, color: Color(0xFFA94907)),
            ),
            IconButton(
              onPressed: () => Get.snackbar('Filter', 'Filter pressed!'),
              icon: const Icon(Icons.filter_list, color: Color(0xFFA94907)),
            ),
          ],
        ),

        // Custom styling
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 1,
      ),

      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Advanced CustomAppBar Usage',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'This example shows:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text('• Custom action widget with multiple buttons'),
              Text('• Custom background color'),
              Text('• Custom elevation'),
              Text('• Direct CustomAppBar widget usage'),
              SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'appBar: CustomAppBar(\n'
                    '  type: AppBarType.backWithAction,\n'
                    '  title: \'Advanced Example\',\n'
                    '  actionWidget: Row(\n'
                    '    children: [\n'
                    '      IconButton(...),\n'
                    '      IconButton(...),\n'
                    '    ],\n'
                    '  ),\n'
                    '  backgroundColor: Colors.white,\n'
                    '  elevation: 1,\n'
                    '),',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
