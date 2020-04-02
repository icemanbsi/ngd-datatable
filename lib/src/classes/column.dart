enum ColumnSort { none, normal, asc, desc }

class NgdDataColumn {
  String title;
  String selector;
  String Function(dynamic) formatter;
  ColumnSort sort;
  bool searchable;
  String filter;
  Map<String, String> filterOptions;

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
      String Function(dynamic) formatter,
      bool searchable = false,
      String filter,
      Map<String, String> filterOptions}) {
    this.title = title;
    this.selector = selector;
    this.formatter = formatter;
    this.sort = sort;
    this.searchable = searchable;
    this.filter = filter;
    this.filterOptions = filterOptions;

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
}
