import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import '../pagination/pagination_component.dart';
import 'package:intl/intl.dart';

@Component(
    selector: 'ngd-datatable-footer',
    templateUrl: 'footer_component.html',
    styleUrls: [
      'footer_component.css'
    ],
    directives: [
      coreDirectives,
      NgdDataTablePaginationComponent,
    ])
class NgdDataTableFooterComponent {
  @Input()
  int numberOfData;

  @Input()
  int pageLimit;

  @Input()
  int currentPage;

  @Output()
  Stream<int> get pageChange => _onPageChange.stream;
  final _onPageChange = StreamController<int>.broadcast();

  String get numberOfShowedData {
    if (currentPage != null && pageLimit != null) {
      var formatter = NumberFormat.decimalPattern();
      var start = formatter.format((currentPage - 1) * pageLimit + 1);
      var end = formatter.format(min(numberOfData, currentPage * pageLimit));
      var total = formatter.format(numberOfData);
      return 'showing data ${start}-${end} of ${total}';
    }
    return '';
  }

  void pageClick(int page) {
    _onPageChange.add(page);
  }
}
