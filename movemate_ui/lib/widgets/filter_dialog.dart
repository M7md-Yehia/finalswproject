import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  final String? selectedStatus;
  final ValueChanged<String?> onFilter;

  const FilterDialog({
    super.key,
    required this.selectedStatus,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter by Status'),
      content: DropdownButton<String>(
        value: selectedStatus,
        isExpanded: true,
        items: [
          'All',
          'Waiting to collect',
          'In transit',
          'Delivered',
          'Customs clearance completed'
        ]
            .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
            .toList(),
        onChanged: (value) {
          Navigator.pop(context);
          onFilter(value); // Apply filter after closing
        },
      ),
    );
  }
}
