class Document {
  String id;
  String docURL;

  Document({this.id, this.docURL});

  Map<String, dynamic> map() {
    return {'id': this.id, 'url': this.docURL};
  }

  bool isDocComplete() => docURL != null && id != null && id.isNotEmpty;
}
