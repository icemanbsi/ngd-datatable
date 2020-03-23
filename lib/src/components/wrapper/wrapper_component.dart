import 'dart:core';
import 'package:angular/angular.dart';
import 'package:angular/core.dart';

@Component(
    selector: 'ngd-datatable-wrapper',
    templateUrl: 'wrapper_component.html',
    styleUrls: [
      'wrapper_component.css'
    ],
    directives: [
      coreDirectives,
    ])
class NgdDataTableWrapperComponent {}
