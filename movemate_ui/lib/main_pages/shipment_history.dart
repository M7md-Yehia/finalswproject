import 'package:flutter/material.dart';

class ShipmentHistoryPage extends StatelessWidget {
  const ShipmentHistoryPage({Key? key}) : super(key: key);

  final List<Map<String, String>> shipments = const [
    {
      "trackingNumber": "TRK123456789",
      "date": "2024-12-15",
      "status": "Delivered",
      "details": "Received by John Doe"
    },
    {
      "trackingNumber": "TRK987654321",
      "date": "2024-12-10",
      "status": "In Transit",
      "details": "Expected Delivery: 2024-12-20"
    },
    {
      "trackingNumber": "TRK111222333",
      "date": "2024-11-30",
      "status": "Returned",
      "details": "Package returned to sender"
    },
    {
      "trackingNumber": "TRK444555666",
      "date": "2024-11-25",
      "status": "Delivered",
      "details": "Left at front porch"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipment History"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: shipments.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final shipment = shipments[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(
              Icons.local_shipping,
              color: shipment['status'] == 'Delivered'
                  ? Colors.green
                  : (shipment['status'] == 'Returned'
                      ? Colors.red
                      : Colors.orange),
            ),
            title: Text(
              shipment['trackingNumber'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date: ${shipment['date']}"),
                Text("Status: ${shipment['status']}"),
                if (shipment['details'] != null)
                  Text("Details: ${shipment['details']}"),
              ],
            ),
            onTap: () {
              // Handle tap if needed (e.g., show details dialog)
            },
          );
        },
      ),
    );
  }
}
