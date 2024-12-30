import 'package:flutter/material.dart';

class TrackingCard extends StatelessWidget {
  final Map<String, String> data;
  final bool isExpanded;
  final VoidCallback onTap;

  const TrackingCard({
    super.key,
    required this.data,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Shipment Number and Status Icon
            Row(
              children: [
                _buildStatusIcon(data['status']!), // Status Icon on the left
                const SizedBox(width: 12), // Spacing between icon and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shipment Number',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['shipmentNumber']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.local_shipping_outlined,
                    color: Colors.orange), // Truck icon remains on the right
              ],
            ),
            const SizedBox(height: 10),

            // Sender and Receiver
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Sender',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(data['sender']!, style: const TextStyle(fontSize: 16)),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Receiver',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(data['receiver']!, style: const TextStyle(fontSize: 16)),
                ]),
              ],
            ),

            // Expanded Section
            if (isExpanded) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Time',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(data['time']!, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Status',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(data['status']!,
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           Register()), // Navigate to Register screen
                    // );
                  },
                  child: const Text(
                    'View on Map',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Method to Build the Status Icon
  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;

    if (status.contains('Departed')) {
      icon = Icons.flight_takeoff;
      color = Colors.orange;
    } else if (status.contains('Arrived')) {
      icon = Icons.home_work_outlined;
      color = Colors.blue;
    } else if (status.contains('Customs clearance')) {
      icon = Icons.local_shipping;
      color = Colors.yellow.shade700;
    } else if (status.contains('Out for delivery')) {
      icon = Icons.delivery_dining;
      color = Colors.green;
    } else if (status.contains('Delivered')) {
      icon = Icons.check_circle;
      color = Colors.green;
    } else {
      icon = Icons.info;
      color = Colors.grey;
    }

    return Icon(icon, size: 24, color: color);
  }
}
