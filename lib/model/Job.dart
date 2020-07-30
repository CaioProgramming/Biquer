class Job {
  String userID;
  double price;
  String id;

  factory Job.fromMap(Map<String, dynamic> map, String key) {
    return new Job(
      userID: map['userID'] as String,
      price: map['price'] as double,
      id: key,
    );
  }

  Map<String, dynamic> toMap() {
    return {'userID': this.userID, 'price': this.price.ceilToDouble()};
  }

  Job({this.userID, this.price, this.id});

  bool hasData() => userID != null && price != null;
}
