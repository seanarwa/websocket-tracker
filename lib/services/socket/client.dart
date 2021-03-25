import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:websocket_tracker/models/event.dart';
import 'package:websocket_tracker/services/event/event_controller.dart';

class SocketIOClient {
  final String url;
  IO.Socket socket;

  SocketIOClient(
    this.url,
  );

  Future<void> connect() async {
    this.socket = IO.io(
      this.url,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    print("Connected to ${this.url}");
    socket.on('message', (message) {
      Event event = Event.fromHashMap(message['data']);
      EventController().emit(event);
    });
  }

  Stream<Event> onEvent(String eventName) {
    return EventController().onEvent(eventName);
  }
}
