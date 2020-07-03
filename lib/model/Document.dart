class Document {
  String id;
  String docURL;

  Document({this.id, this.docURL});

  bool isDocComplete() => docURL != null && id != null && id.isNotEmpty;
}
