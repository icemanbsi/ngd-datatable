import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:ngdart/angular.dart';
import 'package:ngd_datatable/ngd_datatable.dart';

// ignore: uri_has_not_been_generated 
import 'index.template.dart' show DemoComponentNgFactory, ActionComponentNgFactory;


@Component(
  selector: 'app',
  templateUrl: 'demo.html',
  directives: [
    coreDirectives,
    ngdDataTableDirectives
  ]
)
class DemoComponent implements OnInit{
  List<NgdDataColumn> columns = [];
  List<NgdDataColumn> serverSideColumns = [];
  List<NgdDataColumn> employeeColumns = [];
  List<NgdDataColumn> filterColumns = [];
  List<dynamic> data = [];
  List<dynamic> serverSideData = [];
  List<Employee> employeeData = [];
  int serverSideDataLength = 0;
  int pageLimit = 15;
  int page = 1;
  String? sortCol;
  ColumnSort? sortDir;
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
    serverSideColumns = List.from(columns);
    employeeColumns = [
      NgdDataColumn(
        title: 'Employee Name',
        sort: ColumnSort.normal,
        formatter: (item) => (item as Employee).name,
        flexWidth: 2
      ),
      NgdDataColumn(
        title: 'Department',
        sort: ColumnSort.normal,
        headerAlignment: CellAlignment.left,
        alignment: CellAlignment.left,
        formatter: (item) => (item as Employee).department
      ),
      NgdDataColumn(
        title: 'Marital Status',
        headerAlignment: CellAlignment.center,
        alignment: CellAlignment.center,
        formatter: (item) => (item as Employee).maritalStatus
      ),
      NgdDataColumn(
        title: 'Joined Year',
        headerAlignment: CellAlignment.right,
        alignment: CellAlignment.right,
        width: 70,
        formatter: (item) => (item as Employee).joinedYear.toString(),
        cellClass: 'customCellClass',
        headerClass: 'customHeaderClass'
      ),
      NgdDataColumn(
        title: 'Employee Number',
        sort: ColumnSort.normal,
        formatter: (item) => (item as Employee).number
      ),
      NgdDataColumn(
        title: 'Actions',
        component: ActionComponentNgFactory,
        headerAlignment: CellAlignment.right,
        alignment: CellAlignment.right,
        initComponent: (componentRef, item){
          if(componentRef.instance is ActionComponent){
            componentRef.instance.item = item;
          }
        }
      )
    ];
    filterColumns = [
      NgdDataColumn(
        title: 'Employee Name',
        sort: ColumnSort.asc,
        searchable: true,
      ),
      NgdDataColumn(
        title: 'Department',
        sort: ColumnSort.normal
      ),
      NgdDataColumn(
        title: 'Marital Status',
        searchable: true,
        filter: 'Married',
        filterOptions: {
          '' : 'All',
          'Single' : 'Single',
          'Married' : 'Married',
          'Divorced': 'Divorced',
          'Common-Law' : 'Common-Law'
        }
      ),
      NgdDataColumn(
        title: 'Joined Year',
        searchable: true,
        filter: '2000',
        width: 100
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
      employeeData = [];
      data.forEach((item){
        employeeData.add(Employee.fromJson(item));
      });
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

@Component(
  selector: 'act',
  template: '''
    <a href="javascript:;" (click)="clicked">{{ item.name }} Detail</a>
  ''',
  directives: [
    coreDirectives
  ]
)
class ActionComponent{
  @Input()
  dynamic item;

  void clicked(){
    print((item as Employee).name);
  }
}

void main() {
  runApp(DemoComponentNgFactory);
}

class Employee{
  String name = '';
  String department = '';
  String maritalStatus = '';
  int joinedYear = 1970;
  String number = '';

  Employee.fromJson(json){
    name = json['employeeName'];
    department = json['department'];
    maritalStatus = json['maritalStatus'];
    joinedYear = int.parse(json['joinedYear'].toString());
    number = json['employeeNumber'].toString();
  }
}