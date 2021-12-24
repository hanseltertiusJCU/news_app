class SourceData {
  // ignore: slash_for_doc_comments
  /**
   * {
        "id": null,
        "name": "Mirror Online"
      }
   */

  final String? id;
  final String? name;

  SourceData({this.id, this.name});

  factory SourceData.fromJson(Map<String, dynamic> json) => SourceData(
        id: json["id"] ?? "null",
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "null",
        "name": name,
      };
}
