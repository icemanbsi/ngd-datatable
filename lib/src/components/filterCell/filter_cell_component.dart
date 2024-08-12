import 'dart:async';
import 'dart:core';
import 'dart:html';
import 'package:angular/angular.dart';
import '../../../ngd_datatable.dart';
import '../../classes/column.dart';

@Component(
    selector: 'ngd-datatable-filter-cell',
    templateUrl: 'filter_cell_component.html',
    styleUrls: [
      'filter_cell_component.css'
    ],
    directives: [
      coreDirectives,
    ])
class NgdDataTableFilterCellComponent implements OnInit{
  @Input()
  NgdDataColumn? column;

  @Input()
  int? height;

  @Output()
  Stream<NgdDataColumn> get filterChange => _onFilterChange.stream;
  final _onFilterChange = StreamController<NgdDataColumn>.broadcast();

  void onFilterChange(Event event){
    if(column != null){
      if(column?.filterOptions == null){
        column!.filter = (event.target as InputElement).value ?? '';
      }
      else{
        column!.filter = (event.target as SelectElement).value ?? '';
      }
      _onFilterChange.add(column!);
    }
  }

  @override
  void ngOnInit() {
    // filter = column != null ? column.filter.toString() : '';
  }
}
