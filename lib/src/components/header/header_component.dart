import 'dart:async';
import 'dart:core';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import '../../classes/column.dart';
import '../row/row_component.dart';
import '../headerCell/header_cell_component.dart';

@Component(
    selector: 'ngd-datatable-header',
    templateUrl: 'header_component.html',
    styleUrls: [
      'header_component.css'
    ],
    directives: [
      coreDirectives,
      NgdDataTableRowComponent,
      NgdDataTableHeaderCellComponent,
    ])
class NgdDataTableHeaderComponent {
  @Input()
  List<NgdDataColumn> columns;

  @Input()
  int height;

  @Output()
  Stream<NgdDataColumn> get sortChange => _onSortChange.stream;
  final _onSortChange = StreamController<NgdDataColumn>.broadcast();

  void columnSortChange(NgdDataColumn column) {
    _onSortChange.add(column);
  }
}
