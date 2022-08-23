import 'dart:async';
import 'dart:core';
import 'package:angular/angular.dart';
import '../../classes/column.dart';
import '../row/row_component.dart';
import '../headerCell/header_cell_component.dart';
import '../filterCell/filter_cell_component.dart';

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
      NgdDataTableFilterCellComponent
    ])
class NgdDataTableHeaderComponent {
  @Input()
  List<NgdDataColumn> columns;

  @Input()
  int height;

  @Output()
  Stream<NgdDataColumn> get sortChange => _onSortChange.stream;
  final _onSortChange = StreamController<NgdDataColumn>.broadcast();

  @Output()
  Stream<NgdDataColumn> get filterChange => _onFilterChange.stream;
  final _onFilterChange = StreamController<NgdDataColumn>.broadcast();

  bool get isShowColumnFilter{
    var result = false;
    columns.forEach((column){
      if(column.searchable) result = true;
    });
    return result;
  }

  String getStyles(NgdDataColumn column){
    var _styles = '';
    if(column.width != null){
      _styles += ' flex: none; width: ' + column.width.toString() + 'px';
    }
    else if(column.flexWidth != null){
      _styles += ' flex: ' + column.flexWidth.toString();
    }
    return _styles;
  }

  void columnSortChange(NgdDataColumn column) {
    _onSortChange.add(column);
  }
  
  void columnFilterChange(NgdDataColumn column) {
    _onFilterChange.add(column);
  }
}
