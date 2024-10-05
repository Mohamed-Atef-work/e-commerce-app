class EphemeralKeyModel {
  String? id;
  int? created;
  int? expires;
  String? object;
  bool? liveMode;
  String? secret;
  List<AssociatedObjects>? associatedObjects;

  EphemeralKeyModel({
    this.id,
    this.secret,
    this.object,
    this.created,
    this.expires,
    this.liveMode,
    this.associatedObjects,
  });

  EphemeralKeyModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    object = json["object"];
    associatedObjects = json["associated_objects"] == null
        ? null
        : (json["associated_objects"] as List)
            .map((e) => AssociatedObjects.fromJson(e))
            .toList();
    created = (json["created"] as num).toInt();
    expires = (json["expires"] as num).toInt();
    liveMode = json["livemode"];
    secret = json["secret"];
  }
}

class AssociatedObjects {
  String? id;
  String? type;

  AssociatedObjects({this.id, this.type});

  AssociatedObjects.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    type = json["type"];
  }
}
