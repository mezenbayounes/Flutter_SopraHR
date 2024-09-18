import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SocketService {
  late IO.Socket socket;

  // Pass the FlutterLocalNotificationsPlugin instance
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  SocketService({required this.flutterLocalNotificationsPlugin});

  void initSocket() {
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to the socket
    socket.connect();

    // Handle socket events
    socket.on('connect', (_) {
      print('Connected');
    });

    socket.on('disconnect', (_) {
      print('Disconnected');
    });

    // Listen for notification events from the server
    socket.on('notification', (data) {
      print('Notification received: $data');
      _showNotification(data['content']);
    });

    socket.on('response', (data) {
      print('Response from server: $data');
    });
  }

  // Method to show a local notification
  Future<void> _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'conge_channel_id', // Channel ID
      'Conge Notifications', // Channel name
      channelDescription: 'Channel for conge notifications',
      importance: Importance.max,
      icon:
          '@drawable/ic_notification', // Use launcher icon for the notification

      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'New Notification', // Notification title
      message, // Notification body
      platformChannelSpecifics,
    );
  }

  void sendMessage(String type, String content, int userId) {
    socket.emit('message', {
      'type': type,
      'content': content,
      'userId': userId,
    });
  }

  void sendUserID(int userId) {
    socket.emit('sendUserID', {
      'userId': userId,
    });
  }

  void dispose() {
    socket.disconnect();
  }

  
}
