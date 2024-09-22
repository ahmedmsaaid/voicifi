class SaveUrl {
  final String? upload_url;

  SaveUrl({required this.upload_url});

  factory SaveUrl.fromJson(Map<String, dynamic> jsonData) {
    return SaveUrl(upload_url: jsonData['upload_url']);
  }

  Map<String, dynamic> toJson() {
    return {"upload_url": upload_url};
  }
}

class GetId {
  final String? id;

  GetId({required this.id});

  factory GetId.fromJson(Map<String, dynamic> jsonData) {
    return GetId(id: jsonData['id']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id};
  }
}
