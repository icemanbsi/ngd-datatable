import 'dart:async';
import 'dart:core';
import 'package:angular/angular.dart';
import '../../../ngd_datatable.dart';
import '../../classes/column.dart';

@Component(
    selector: 'ngd-datatable-header-cell',
    templateUrl: 'header_cell_component.html',
    styleUrls: [
      'header_cell_component.css'
    ],
    directives: [
      coreDirectives,
    ])
class NgdDataTableHeaderCellComponent {
  @Input()
  NgdDataColumn column;

  @Output()
  Stream<NgdDataColumn> get sortChange => _onSortChange.stream;
  final _onSortChange = StreamController<NgdDataColumn>.broadcast();

  @Input()
  int height;

  String get classes {
    var _classes = (column.headerClass ?? '') + ' th';
    if (column.sort != ColumnSort.none) {
      _classes += ' sortable';
    }
    if (column.sort == ColumnSort.asc) {
      _classes += ' asc';
    } else if (column.sort == ColumnSort.desc) {
      _classes += ' desc';
    }

    switch (column.headerAlignment) {
      case CellAlignment.left: _classes += ' text-left'; break;
      case CellAlignment.center: _classes += ' text-center'; break;
      case CellAlignment.right: _classes += ' text-right'; break;
      case CellAlignment.justify: _classes += ' text-justify'; break;
      default:
    }

    return _classes;
  }

  String get styles {
    var _styles = '';
    if(height != null){
      _styles += ' height: ' + height.toString() + 'px;';
    }
    return _styles;
  }

  void headerClick() {
    if (column.sort != ColumnSort.none) {
      if (column.sort == ColumnSort.normal) {
        column.sort = ColumnSort.asc;
      } else if (column.sort == ColumnSort.asc) {
        column.sort = ColumnSort.desc;
      } else if (column.sort == ColumnSort.desc) {
        column.sort = ColumnSort.normal;
      }
      _onSortChange.add(column);
    }
  }
}
