import 'dart:core';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import '../../classes/column.dart';
import '../row/row_component.dart';
import '../cell/cell_component.dart';

@Component(
    selector: 'ngd-datatable-body',
    templateUrl: 'body_component.html',
    styleUrls: [
      'body_component.css'
    ],
    directives: [
      coreDirectives,
      NgdDataTableRowComponent,
      NgdDataTableCellComponent,
    ])
class NgdDataTableBodyComponent {
  @Input()
  List<NgdDataColumn> columns;

  @Input()
  List<dynamic> data;
}
