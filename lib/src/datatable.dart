import 'dart:async';
import 'dart:core';
import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';

import 'classes/column.dart';
import 'components/body/body_component.dart';
import 'components/footer/footer_component.dart';
import 'components/header/header_component.dart';
import 'components/progress/progress_component.dart';
import 'components/wrapper/wrapper_component.dart';

@Component(
  selector: 'ngd-datatable',
  templateUrl: 'datatable_template.html',
  styleUrls: ['datatable_style.css'],
  directives: [
    coreDirectives,
    NgdDataTableHeaderComponent,
    NgdDataTableBodyComponent,
    NgdDataTableFooterComponent,
    NgdDataTableWrapperComponent,
    NgdDataTableProgressComponent,
  ]
)
class NgdDataTableComponent{
  @Input()
  List<NgdDataColumn> columns;
  
  @Input()
  set data(List<dynamic> newData){
    _originalData = newData;
    _data = List<dynamic>.from(newData);
  }
  List<dynamic> _originalData;
  List<dynamic> _data;

  @Input()
  int pageLimit = 25;
  
  @Input()
  set page(int value){
    if(value != _page){
      setPageState(value);
    }
  }
  int get page => _page;

  @Output()
  Stream<int> get pageChange => _onPageChange.stream;
  final _onPageChange = StreamController<int>.broadcast();
  int _page = 1;

  @Input()
  set count(int value){
    _count = value;
  }
  int get count => _count ?? _originalData.length;
  int _count;

  @Input()
  int headerHeight = 42;

  @Input()
  bool externalProcessing = false;

  @Input()
  bool loading = false;

  @Output()
  Stream<int> get pageClick => _onPageClick.stream;
  final _onPageClick = StreamController<int>.broadcast();

  @Output()
  Stream<NgdDataColumn> get sortClick => _onSortChange.stream;
  final _onSortChange = StreamController<NgdDataColumn>.broadcast();


  List<dynamic> get showedData{
    if(externalProcessing){
      return _data;
    }
    else{
      var start = (_page - 1) * pageLimit;
      var end = min(_page * pageLimit, _data.length);
      return _data.length > start ? _data.sublist(start, end) : [];
    }
  }

  void setPageState(int value){
    _page = value;
    _onPageChange.add(_page);
    _onPageClick.add(page);
  }

  void pageClicked(int page){
    setPageState(page);
  }

  void colSortChange(NgdDataColumn column){
    if(!externalProcessing){
      columns.forEach((col){
        if(column != col && col.sort != ColumnSort.none){
          col.sort = ColumnSort.normal;
        }
      });
      if(column.sort == ColumnSort.normal){
        _data = List<dynamic>.from(_originalData);
      }
      else{
        _data.sort((a, b) {
          if(column.sort == ColumnSort.asc){
            return a[column.selector].compareTo(b[column.selector]);
          }
          else{
            return a[column.selector].compareTo(b[column.selector]) * -1;
          }
        });
      }
    }
    _onSortChange.add(column);
  }
}
