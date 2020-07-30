import 'package:Biquer/model/Job.dart';
import 'package:Biquer/model/category/Category.dart';

class Service extends Category {
  double minPrice;
  double averagePrice;
  String title;
  String subtitle;
  String posterImage;
  String titleColor;
  String id;
  List<Job> jobs;

  factory Service.fromMap(Map<String, dynamic> map, String key) {
    print('converting $map');
    return new Service(
      minPrice: map['minPrice'] as double,
      averagePrice: map['averagePrice'] as double,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      posterImage: map['posterImage'] as String,
      titleColor: map['titleColor'] as String,
      id: key,
    );
  }

  List<Map<String, dynamic>> jobsToMapList() {
    List jobsMaps = [];
    for (var job in jobs) {
      jobsMaps.add(job.toMap());
    }
    return jobsMaps;
  }

  Map<String, dynamic> toMap() {
    return {
      'minPrice': this.minPrice,
      'averagePrice': this.averagePrice,
      'title': this.title,
      'subtitle': this.subtitle,
      'posterImage': this.posterImage,
      'titleColor': this.titleColor,
      'jobs': jobsToMapList()
    };
  }

  Service(
      {this.minPrice,
      this.averagePrice,
      this.title,
      this.subtitle,
      this.posterImage,
      this.titleColor,
      this.id});
}
