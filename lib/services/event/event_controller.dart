import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:websocket_tracker/models/event.dart';

class EventController {
  EventController._internal();

  static final EventController _instance = EventController._internal();
  final EventBus _eventBus = EventBus();

  factory EventController() {
    return _instance;
  }

  void emit(Event event) {
    _eventBus.fire(event);
  }

  Stream<Event> onEvent(String eventName) {
    return _eventBus.on<Event>().transform(
      StreamTransformer.fromHandlers(
        handleData: (Event event, EventSink<Event> sink) {
          if (eventName.isEmpty || event.name == eventName) {
            sink.add(event);
          }
        },
      ),
    );
  }
}
