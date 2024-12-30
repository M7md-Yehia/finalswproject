import 'package:flutter/material.dart';

class tracking_cardd2 extends StatelessWidget {
  final Map<String, String> data;
  final bool isExpanded;
  final VoidCallback onTap;

  const tracking_cardd2({
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
                _buildStatusIcon(data['status'] ?? ''),
                const SizedBox(width: 12),
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
                        data['shipmentNumber'] ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.local_shipping_outlined, color: Colors.orange),
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
                  Text(
                    data['sender'] ?? 'Unknown',
                    style: const TextStyle(fontSize: 16),
                  ),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Receiver',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(
                    data['receiver'] ?? 'Unknown',
                    style: const TextStyle(fontSize: 16),
                  ),
                ]),
              ],
            ),
            const SizedBox(height: 16),

            // Two Buttons: Accept and Decline
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Accept action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Decline action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text('Decline'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
