import 'package:angular/angular.dart';

enum ColumnSort { none, normal, asc, desc }
enum CellAlignment { left, center, right, justify }

class NgdDataColumn {
  String title;
  String selector;
  String Function(dynamic) formatter;
  ComponentFactory component;
  Function(ComponentRef, dynamic) initComponent;
  ColumnSort sort;
  String cellClass;
  String headerClass;
  bool searchable;
  String filter;
  Map<String, String> filterOptions;
  CellAlignment alignment;
  CellAlignment headerAlignment;
  int width;
  double flexWidth;

  @override
  bool operator ==(other) {
    return (other is NgdDataColumn) &&
        title == other.title &&
        selector == other.selector;
  }

  NgdDataColumn(
      {String title,
      String selector,
      ColumnSort sort = ColumnSort.none,
      String cellClass,
      String headerClass,
      String Function(dynamic) formatter,
      ComponentFactory component,
      Function(ComponentRef, dynamic) initComponent,
      bool searchable = false,
      String filter,
      Map<String, String> filterOptions,
      CellAlignment alignment,
      CellAlignment headerAlignment,
      int width,
      double flexWidth}) {
    this.title = title;
    this.selector = selector;
    this.formatter = formatter;
    this.component = component;
    this.initComponent = initComponent;
    this.sort = sort;
    this.cellClass = cellClass;
    this.headerClass = headerClass;
    this.searchable = searchable;
    this.filter = filter;
    this.filterOptions = filterOptions;
    this.alignment = alignment;
    this.headerAlignment = headerAlignment;
    this.width = width;
    this.flexWidth = flexWidth;

    if (this.selector == null || this.selector.isEmpty) {
      this.selector = toCamelCase(title);
    }
  }

  String toCamelCase(String text) {
    String result;
    if (text != null) {
      var text_r = text.replaceAll('  ', ' ').split(' ');
      if (text_r.isNotEmpty) {
        var i = 0;
        text_r.forEach((word) {
          if(word.isNotEmpty){
            if (i == 0) {
              text_r[i++] = word.substring(0, 1).toLowerCase() +
                  ((word.length > 1) ? word.substring(1) : '');
            } else {
              text_r[i++] = word.substring(0, 1).toUpperCase() +
                  ((word.length > 1) ? word.substring(1) : '');
            }
          }
        });
      }
      result = text_r.join();
    }

    return result;
  }

  String getContent(dynamic item){
    if (component == null){
      if (item is Map && item.containsKey(selector)) {
        if (formatter != null) {
          return formatter(item);
        } else {
          return item[selector].toString();
        }
      } else {
        if (formatter != null) {
          return formatter(item);
        } else {
          return '';
        }
      }
    }
    else{
      return '';
    }
  }
}
