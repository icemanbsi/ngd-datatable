import 'dart:core';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import '../../classes/column.dart';

@Component(
    selector: 'ngd-datatable-cell',
    templateUrl: 'cell_component.html',
    styleUrls: [
      'cell_component.css'
    ],
    directives: [
      coreDirectives,
    ])
class NgdDataTableCellComponent {
  @Input()
  NgdDataColumn column;

  @Input()
  dynamic item;

  String get formattedContent {
    return column.getContent(item);
  }
}
