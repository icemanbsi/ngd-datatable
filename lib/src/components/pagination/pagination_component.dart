import 'dart:async';
import 'dart:core';
import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';

@Component(
    selector: 'ngd-datatable-pagination',
    templateUrl: 'pagination_component.html',
    styleUrls: [
      'pagination_component.css'
    ],
    directives: [
      coreDirectives,
    ])
class NgdDataTablePaginationComponent {
  @Input()
  int numberOfData;

  @Input()
  int pageLimit;

  @Input()
  int currentPage;

  int get totalPages {
    return (numberOfData / pageLimit).ceil();
  }

  @Output()
  Stream<int> get change => _onChange.stream;
  final _onChange = StreamController<int>.broadcast();

  List<int> get pages {
    var result = <int>[];
    if (totalPages <= 5) {
      for (var i = 1; i <= totalPages; i++) {
        result.add(i);
      }
    } else {
      var start = currentPage <= totalPages - 2
          ? max(currentPage - 2, 1)
          : totalPages - 4;
      for (var i = start; i < start + 5; i++) {
        result.add(i);
      }
    }
    return result;
  }

  void firstClick(Event _) {
    _onChange.add(1);
  }

  void prevClick(Event _) {
    _onChange.add(max(currentPage - 1, 1));
  }

  void nextClick(Event _) {
    _onChange.add(min(currentPage + 1, totalPages));
  }

  void lastClick(Event _) {
    _onChange.add(totalPages);
  }

  void pageClick(int page) {
    _onChange.add(page);
  }
}
