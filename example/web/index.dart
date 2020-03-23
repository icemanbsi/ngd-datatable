import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:angular/angular.dart';
import 'package:ngd_datatable/ngd_datatable.dart';

// ignore: uri_has_not_been_generated 
import 'index.template.dart' show DemoComponentNgFactory;


@Component(
  selector: 'app',
  templateUrl: 'demo.html',
  directives: [
    coreDirectives,
    ngdDataTableDirectives
  ]
)
class DemoComponent implements OnInit{
  List<NgdDataColumn> columns;
  List<dynamic> data = [];
  List<dynamic> serverSideData = [];
  int serverSideDataLength = 0;
  int pageLimit = 15;
  int page = 1;
  String sortCol;
  ColumnSort sortDir;
  bool isLoading = false;

  @override
  void ngOnInit() {
    columns = [
      NgdDataColumn(
        title: 'Employee Name',
        sort: ColumnSort.normal
      ),
      NgdDataColumn(
        title: 'Department',
        sort: ColumnSort.normal
      ),
      NgdDataColumn(
        title: 'Marital Status'
      ),
      NgdDataColumn(
        title: 'Joined Year'
      ),
      NgdDataColumn(
        title: 'Employee Number',
        sort: ColumnSort.normal
      ),
    ];

    fetchData();
    fetchServerSideData();
  }

  Future<void> fetchData() async {
    const path = 'https://icemanbsi.github.io/ngd-datatable/data/simple.json';
    try {
      final jsonString = await HttpRequest.getString(path);
      data = json.decode(jsonString);
    } catch (e) {
      // The GET request failed. Handle the error.
      print(e);
      print('Couldn\'t open $path');
    }
  }

  Future<void> fetchServerSideData() async{
    isLoading = true;
    const path = 'https://icemanbsi.github.io/ngd-datatable/data/simple.json';
    try {
      final jsonString = await HttpRequest.getString(path);
      List<dynamic> temp = json.decode(jsonString);
      serverSideDataLength = temp.length;
      if(sortCol != null && sortDir != null){
        temp.sort((a, b) {
          if(sortDir == ColumnSort.asc){
            return a[sortCol].compareTo(b[sortCol]);
          }
          else{
            return a[sortCol].compareTo(b[sortCol]) * -1;
          }
        });
      }
      var start = (page - 1) * pageLimit;
      var end = min(page * pageLimit, serverSideDataLength);
      serverSideData = temp.length > start ? temp.sublist(start, end) : [];
    } catch (e) {
      // The GET request failed. Handle the error.
      print(e);
      print('Couldn\'t open $path');
    }
    isLoading = false;
  }

  void pageClick(int page){
    fetchServerSideData();
  }

  void sortClick(NgdDataColumn column){
    sortCol = column.selector;
    sortDir = column.sort;
    fetchServerSideData();
  }
}

void main() {
  runApp(DemoComponentNgFactory);
}