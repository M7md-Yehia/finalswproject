import 'package:flutter/material.dart';
import 'package:movemate_ui/main_pages/Profile.dart';
import 'package:movemate_ui/widgets/notification_popup.dart';
import 'package:movemate_ui/widgets/profile_icon.dart';
import 'package:movemate_ui/widgets/filter_dialog.dart';
import 'package:movemate_ui/widgets/tracking_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearchActive = false; // Controls the expanding search bar
  String? selectedStatus = 'All'; // Selected filter status
  String searchQuery = ''; // Current search input
  late List<Map<String, String>> filteredData; // Filtered data list
  late List<bool> readStatus; // Tracks whether notifications are read
  int? expandedIndex; // Tracks which tracking card is expanded

  // Example tracking data
  final List<Map<String, String>> trackingData = [
    {
      'shipmentNumber': 'EGP20089934122231',
      'sender': 'Cairo, 1111',
      'receiver': 'Alexandria, 2222',
      'time': '2 hours',
      'status': 'Departed from Cairo',
      'location': 'Cairo, Egypt',
    },
    {
      'shipmentNumber': 'EGP20089934122232',
      'sender': 'Alexandria, 2222',
      'receiver': 'Port Said, 3333',
      'time': '4 hours',
      'status': 'Arrived at Alexandria Hub',
      'location': 'Alexandria, Egypt',
    },
    {
      'shipmentNumber': 'EGP20089934122233',
      'sender': 'Port Said, 3333',
      'receiver': 'Giza, 4444',
      'time': '1 day',
      'status': 'Customs clearance completed',
      'location': 'Port Said, Egypt',
    },
  ];

  // Example notifications
  final List<Map<String, String>> notifications = [
    {'title': 'Shipment departed from Cairo', 'time': '10 mins ago'},
    {
      'title': 'Shipment arrived at Alexandria Hub',
      'time': '1 hour 20 mins ago'
    },
    {
      'title': 'Customs clearance completed at Port Said',
      'time': '3 hours ago'
    },
    {
      'title': 'Shipment out for delivery in Giza',
      'time': '5 hours 15 mins ago'
    },
    {'title': 'Delivered successfully in Asyut', 'time': '1 day ago'},
    {
      'title': 'Shipment scheduled for pickup in Mansoura',
      'time': '2 days ago'
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredData =
        trackingData; // Initialize the filtered data with all tracking items
    readStatus = List<bool>.filled(
        notifications.length, false); // Mark all notifications as unread
  }

  // Apply filter based on selected status
  void _applyFilter(String? status) {
    setState(() {
      selectedStatus = status;
      _filterData(); // Filter data based on the selected status
    });
  }

  // Apply search query
  void _applySearch(String query) {
    setState(() {
      searchQuery = query;
      _filterData(); // Filter data based on the search query
    });
  }

  // Combine search and status filters
  void _filterData() {
    filteredData = trackingData.where((item) {
      final matchesStatus = selectedStatus == null ||
          selectedStatus == 'All' ||
          item['status'] == selectedStatus;
      final matchesSearch = item['shipmentNumber']!.contains(searchQuery);
      return matchesStatus && matchesSearch;
    }).toList();
  }

  // Mark all notifications as read
  void _markAllNotificationsAsRead() {
    setState(() {
      readStatus = List<bool>.filled(notifications.length, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final data = filteredData[index];
          return TrackingCard(
            data: data,
            isExpanded: expandedIndex == index,
            onTap: () {
              setState(() {
                expandedIndex = expandedIndex == index ? null : index;
              });
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF5A2D82),
      elevation: 0,
      leading: isSearchActive
          ? null // Hide profile icon when search bar is expanded
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            username: '',
                            email: '',
                          )),
                );
              },
              child: const ProfileIcon(),
            ),
      actions: [
        if (!isSearchActive)
          IconButton(
            onPressed: () {
              // Show notification popup
              showDialog(
                context: context,
                builder: (context) => NotificationPopup(
                  notifications: notifications,
                  readStatus: readStatus,
                  onMarkAllAsRead: _markAllNotificationsAsRead,
                ),
              );
            },
            icon: Stack(
              children: [
                const Icon(Icons.notifications, color: Colors.white, size: 28),
                if (readStatus.contains(
                    false)) // Show badge if there are unread notifications
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
      title: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isSearchActive
            ? MediaQuery.of(context).size.width - 40 // Full-width when expanded
            : MediaQuery.of(context).size.width - 120, // Adjust to fill gap
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                autofocus: isSearchActive,
                decoration: InputDecoration(
                  hintText: isSearchActive
                      ? 'Type to search...'
                      : 'Enter the Shipment number...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged:
                    _applySearch, // Updates search query as the user types
                onTap: () => setState(() => isSearchActive = true),
              ),
            ),
            if (isSearchActive)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSearchActive = false;
                    searchQuery =
                        ''; // Clear the search query when search is deactivated
                    _filterData(); // Reset the filter
                  });
                },
                child: const Icon(Icons.close, color: Colors.grey),
              )
            else
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => FilterDialog(
                      selectedStatus: selectedStatus,
                      onFilter: _applyFilter,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF06B22),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.filter_alt_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
