class ItemModel {
  late final String? title;
  late final String? content;
  late final String? date;
  late final int? index;

  ItemModel({this.title, this.content, this.date, this.index});

  factory ItemModel.fromJson(Map<String, dynamic> jsonData) {
    return ItemModel(
      title: jsonData['title'],
      content: jsonData['content'],
      date: jsonData['date'],
      index: jsonData['index'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['date'] = data;
    data['index'] = index;
    return data;
  }
}
