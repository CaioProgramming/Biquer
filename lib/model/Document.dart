class Document {
  String id;
  List<String> docURL;

  Document({this.id, this.docURL});

  bool isDocComplete() => docURL.isNotEmpty;
}
