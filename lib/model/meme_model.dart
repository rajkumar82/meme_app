class Meme {
  Meme({
    this.id,
    this.created,
    this.modified,
    required this.image,
    this.tags,
    this.upvotes,
    this.downvotes,
  });

  final int? id;
  final DateTime? created;
  final DateTime? modified;
  final String? image;
  final dynamic tags;
  final int? upvotes;
  final int? downvotes;

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json["id"],
      created: DateTime.tryParse(json["created"] ?? ""),
      modified: DateTime.tryParse(json["modified"] ?? ""),
      image: json["image"],
      tags: json["tags"],
      upvotes: json["upvotes"],
      downvotes: json["downvotes"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "image": image,
        "tags": tags,
        "upvotes": upvotes,
        "downvotes": downvotes,
      };
}
