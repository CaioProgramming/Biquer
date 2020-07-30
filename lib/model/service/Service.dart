import 'package:Biquer/model/Job.dart';
import 'package:Biquer/model/category/Category.dart';

class Service extends Category {
  double minValue;
  double averageValue;
  String title;
  String subtitle;
  String posterImage;
  String titleColor;
  String id;
  List<Job> jobs;

  factory Service.fromMap(Map<String, dynamic> map, String key) {
    print('converting $map');
    return new Service(
      minValue: map['minValue'] as double,
      averageValue: map['averageValue'] as double,
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
      'minValue': this.minValue,
      'averageValue': this.averageValue,
      'title': this.title,
      'subtitle': this.subtitle,
      'posterImage': this.posterImage,
      'titleColor': this.titleColor,
      'jobs': jobsToMapList()
    };
  }

  Service(
      {this.minValue,
      this.averageValue,
      this.title,
      this.subtitle,
      this.posterImage,
      this.titleColor,
      this.id});
}
