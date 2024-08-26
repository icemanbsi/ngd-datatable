import 'dart:core';
import 'package:ngdart/angular.dart';
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
  NgdDataColumn? column;

  @Input()
  dynamic item;

  @ViewChild('cell', read: ViewContainerRef)
  ViewContainerRef? cellElement;

  String get formattedContent {
    return column?.getContent(item) ?? '';
  }

  String get classes {
    var _classes = column?.cellClass ?? '';
    switch (column?.alignment) {
      case CellAlignment.left: _classes += ' text-left'; break;
      case CellAlignment.center: _classes += ' text-center'; break;
      case CellAlignment.right: _classes += ' text-right'; break;
      case CellAlignment.justify: _classes += ' text-justify'; break;
      default:
    }
    return _classes;
  }

  @override
  void ngOnInit() {
    if (column?.component != null && cellElement != null){
      var componentRef = _loader.loadNextToLocation(column!.component!, cellElement!);
      if(column?.initComponent != null){
        column?.initComponent!(componentRef, item);
      }
    }
  }
}
