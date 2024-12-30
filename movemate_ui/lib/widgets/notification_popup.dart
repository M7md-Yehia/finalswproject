import 'package:flutter/material.dart';

class NotificationPopup extends StatefulWidget {
  final List<Map<String, String>> notifications;
  final List<bool> readStatus; // List to track read/unread status
  final VoidCallback
      onMarkAllAsRead; // Callback to mark all notifications as read

  const NotificationPopup({
    super.key,
    required this.notifications,
    required this.readStatus,
    required this.onMarkAllAsRead,
  });

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Close Button
            Row(
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                  },
                  icon: const Icon(Icons.close, color: Colors.black54),
                ),
              ],
            ),
            const Divider(),

            // Mark All as Read Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  widget.onMarkAllAsRead(); // Call parent callback
                  setState(() {
                    for (int i = 0; i < widget.readStatus.length; i++) {
                      widget.readStatus[i] = true; // Mark all as read locally
                    }
                  });
                },
                child: const Text(
                  "Mark all as read",
                  style: TextStyle(
                    color: Color(0xFF5A2D82),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Notifications List
            Expanded(
              child: ListView.builder(
                itemCount: widget.notifications.length,
                itemBuilder: (context, index) {
                  final notification = widget.notifications[index];
                  final isRead = widget.readStatus[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.notifications,
                        color: isRead ? Colors.grey : Color(0xFF5A2D82),
                      ),
                      title: Text(
                        notification['title']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isRead ? Colors.grey : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        notification['time']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        // Mark this notification as read when tapped
                        setState(() {
                          widget.readStatus[index] = true;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(),

            // See All Button
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to a detailed notifications page
                  Navigator.pop(context); // Close popup for now
                },
                child: const Text(
                  "See all",
                  style: TextStyle(
                    color: Color(0xFF5A2D82),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
