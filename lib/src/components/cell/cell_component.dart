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
class NgdDataTableCellComponent implements OnInit {
  final ComponentLoader _loader;

  NgdDataTableCellComponent(this._loader);

  @Input()
  NgdDataColumn column;

  @Input()
  dynamic item;

  @ViewChild('cell', read: ViewContainerRef)
  ViewContainerRef cellElement;

  String get formattedContent {
    return column.getContent(item);
  }

  @override
  void ngOnInit() {
    if (column.component != null){
      var componentRef = _loader.loadNextToLocation(column.component, cellElement);
      if(column.initComponent != null){
        column.initComponent(componentRef, item);
      }
    }
  }
}
