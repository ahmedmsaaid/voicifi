class TranscpitedData {
  final String? text;

  TranscpitedData({required this.text});

  factory TranscpitedData.fromJson(Map<String, dynamic> jsonData) {
    return TranscpitedData(text: jsonData['text']);
  }

  Map<String, dynamic> toJson() {
    return {"text": text};
  }
}
