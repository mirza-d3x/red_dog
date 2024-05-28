class HelpData {
  final String title;
  final String description;

  HelpData({required this.title, required this.description});

  factory HelpData.fromJson(Map<String, dynamic> json) {
    return HelpData(
      title: json['title'],
      description: json['description'],
    );
  }
}