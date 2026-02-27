import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytownmysymptom/db/dao/dao_custom.dart';
import 'package:mytownmysymptom/model/hospital.dart';

//  Configuration of the App
/*
  Create: 12/12/2025 18:12, Creator: Chansol, Park
  Update log: 
    DUMMY 00/00/0000 00:00, 'Point X, Description', Creator: Chansol, Park
  Version: 1.0
  Desc: Configuration of the App
*/

//  DB
//  For use
//  '${rDBName}${rDBFileExt}';
const String rDBName = 'DBname';  //  Database Name
const String rDBFileExt = '.db';
const int rVersion = 1;

// DB Handlers
final hospitalHandler = RDAO(dbName: rDBName, tableName: "Hospital", dVersion: rVersion, fromMap: Hospital.fromMap);
//  Formats
const String dateFormat = 'yyyy-MM-dd'; //  DateTime Format
const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';  //  DateTime Format to second 
final NumberFormat priceFormatter = NumberFormat('#,###.##'); //  Number format ###,###

final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
);

final RegExp rKeys = RegExp(
  r'"([a-zA-Z_])"\s*:',
);

//  Tables
const String kTableCustomer = 'Customer';
const String kTableProductImage = 'ProductImage';
const String kTableProductBase = 'ProductBase';
const String kTableManufacturer = 'Manufacturer';
const String kTableProduct = 'Product';
const String tTableEmployee = 'Employee';
//  Point 3
const String kTableLoginHistory = 'LoginHistory';
const String kTablePurchaseItem = 'PurchaseItem';


//  Routes
const String routeLogin = '/';
const String routeSettings = '/settings';
const String routeProductDetail = '/product';
const String routeCart = '/cart';
const String routePurchaseHistory = '/history';