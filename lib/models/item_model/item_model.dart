class ItemModel {
  final String? title;
  final String? content;

  final int? index;
  final DateTime? recordedTime;

  ItemModel({
    required this.title,
    required this.content,
    required this.index,
    required this.recordedTime,
  });

  factory ItemModel.fromJson(Map<String, dynamic> jsonData) {
    return ItemModel(
      recordedTime: DateTime.parse(jsonData['recordedTime']),
      title: jsonData['title'],
      content: jsonData['content'],
      index: jsonData['index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'index': index,
      'recordedTime': recordedTime!.toIso8601String()
    };
  }
}
