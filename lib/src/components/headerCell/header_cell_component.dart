import 'dart:async';
import 'dart:core';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import '../../../ngd_datatable.dart';
import '../../classes/column.dart';

@Component(
  selector: 'ngd-datatable-header-cell',
  templateUrl: 'header_cell_component.html',
  styleUrls: ['header_cell_component.css'],
  directives: [
    coreDirectives,
  ]
)
class NgdDataTableHeaderCellComponent{
  @Input()
  NgdDataColumn column;

  @Output()
  Stream<NgdDataColumn> get sortChange => _onSortChange.stream;
  final _onSortChange = StreamController<NgdDataColumn>.broadcast();
  
  @Input()
  int height;
  
  String get classes{
    var _classes = 'th';
    if (column.sort != ColumnSort.none){
      _classes += ' sortable';
    }
    if (column.sort == ColumnSort.asc){
      _classes += ' asc';
    }
    else if (column.sort == ColumnSort.desc){
      _classes += ' desc';
    }

    return _classes;
  }

  void headerClick(){
    if (column.sort != ColumnSort.none){
      if(column.sort == ColumnSort.normal){
        column.sort = ColumnSort.asc;
      }
      else if(column.sort == ColumnSort.asc){
        column.sort = ColumnSort.desc;
      }
      else if(column.sort == ColumnSort.desc){
        column.sort = ColumnSort.normal;
      }
      _onSortChange.add(column);
    }
  }
}
