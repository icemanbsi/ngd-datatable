import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:ngdart/angular.dart';
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
  int? numberOfData;

  @Input()
  int? pageLimit;

  @Input()
  int? currentPage;

  @Output()
  Stream<int> get pageChange => _onPageChange.stream;
  final _onPageChange = StreamController<int>.broadcast();

  String get numberOfShowedData {
    if (currentPage != null && pageLimit != null) {
      var formatter = NumberFormat.decimalPattern();
      var start = formatter.format(max(0, (currentPage! - 1) * pageLimit! + 1));
      var end = formatter.format(min(numberOfData ?? 0, currentPage! * pageLimit!));
      var total = formatter.format(numberOfData ?? 0);
      if(numberOfData == 0){
        start = '0';
      }
      return 'showing data ${start}-${end} of ${total}';
    }
    return '';
  }

  void pageClick(int page) {
    _onPageChange.add(page);
  }
}
