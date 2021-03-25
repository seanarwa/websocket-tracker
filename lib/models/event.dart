class Event {
  String name;
  dynamic data;

  Event({
    this.name,
    this.data,
  }) : assert(name != null);

  Event.fromHashMap(dynamic data) {
    this.name = data["name"];
    this.data = data;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "data": this.data,
    };
  }

  @override
  String toString() {
    return "Event(${this.toMap()})";
  }
}
