import 'dart:core';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';

@Component(
    selector: 'ngd-datatable-row',
    templateUrl: 'row_component.html',
    styleUrls: [
      'row_component.css'
    ],
    directives: [
      coreDirectives,
    ])
class NgdDataTableRowComponent {}
