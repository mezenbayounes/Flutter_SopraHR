import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

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
      // Here you can handle the notification (e.g., show a Snackbar or update UI)
    });

    socket.on('response', (data) {
      print('Response from server: $data');
    });
  }

  void sendMessage(String type, String content, int userId) {
    socket.emit('message', {
      'type': type,
      'content': content,
      'userId': userId,
    });
  }

  void dispose() {
    socket.disconnect();
  }
}
