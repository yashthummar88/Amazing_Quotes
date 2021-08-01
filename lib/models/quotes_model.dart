class Quotes {
  int? id;
  final String quotes;
  final String author;
  final int addFavourite;
  final String type;
  Quotes({
    this.id,
    required this.quotes,
    required this.author,
    required this.type,
    required this.addFavourite,
  });
  static Quotes fromMap(Map<String, dynamic> map) {
    return Quotes(
      id: map["id"],
      quotes: map["quotes"],
      author: map["author"],
      type: map["type"],
      addFavourite: map["addFavourite"],
    );
  }
}
