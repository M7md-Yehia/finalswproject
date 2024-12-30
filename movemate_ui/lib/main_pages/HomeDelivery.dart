import 'package:flutter/material.dart';
import 'Profile.dart';
import 'package:movemate_ui/widgets/tracking_cardd2.dart';
import 'package:movemate_ui/widgets/notification_popup.dart';
import 'package:movemate_ui/widgets/filter_dialog.dart';

class HomeDelivery extends StatefulWidget {
  const HomeDelivery({super.key});

  @override
  State<HomeDelivery> createState() => _HomeDeliveryState();
}

class _HomeDeliveryState extends State<HomeDelivery> {
  bool isSearchActive = false; // Controls whether the search bar is expanded
  String? selectedStatus = 'All'; // Current filter status
  List<Map<String, String>> filteredData = []; // Filtered list of tracking data
  int? expandedIndex; // Tracks which shipment card is expanded

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
    {
      'shipmentNumber': 'EGP20089934122234',
      'sender': 'Giza, 4444',
      'receiver': 'Asyut, 5555',
      'time': '2 days',
      'status': 'Out for delivery',
      'location': 'Giza, Egypt',
    },
    {
      'shipmentNumber': 'EGP20089934122235',
      'sender': 'Asyut, 5555',
      'receiver': 'Mansoura, 6666',
      'time': '3 days',
      'status': 'Delivered successfully',
      'location': 'Asyut, Egypt',
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredData = trackingData; // Initialize with all data
  }

  void _applyFilter(String? status) {
    setState(() {
      selectedStatus = status; // Update selected filter
      if (status == 'All' || status == null) {
        filteredData = trackingData; // Show all data
      } else {
        filteredData = trackingData
            .where((item) => item['status'] == status)
            .toList(); // Filter data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemCount: filteredData.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return tracking_cardd2(
            data: filteredData[index],
            isExpanded: expandedIndex == index,
            onTap: () {
              setState(() {
                expandedIndex = expandedIndex == index ? null : index; // Toggle
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
      title: Row(
        children: [
          const Text("Orders"),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.person, color: Colors.white, size: 28),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(
                      username: '',
                      email: '',
                    )),
          );
        },
      ),
    );
  }
}
