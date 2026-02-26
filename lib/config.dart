import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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



//  Screen Datas
const seedColorDefault = Colors.deepPurple; //  Default Color for seedColor in main.dart
const defaultThemeMode = ThemeMode.system;  //  Default ThemeMode for ThemeMode in main.dart

//  Paths
const String rImageAssetPath = 'images/'; //  Default path for image

//  DB Dummies
const String rDefaultProductImage = '${rImageAssetPath}default.png';  //  Default image for ProductBase

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

//  Searchview presets
const TextStyle rLabel = TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

//  Features
const bool kEnableSaleFeature = true;
const bool kEnableStockAutoRequest = true;
const bool kUseLocalDBOnly = true;

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


// Pickup 상태
Map pickupStatus = {
  0 : '제품 준비 중',
  1 : '제품 준비 완료',
  2 : '제품 수령 완료'};

// Return 상태
Map returnStatus = {
 0 : '반품 신청',
 1 : '반품 처리 중',
 2 : '반품 완료'
};

// 회원 상태 
Map loginStatus =  {
  0 : '활동 회원',
  1 : '휴면 회원',
  2 : '탈퇴 회원'
}; 

// 서울 내 자치구 리스트.
const List<String> district = [
  '강남구',
  '강동구',
  '강북구',
  '강서구',
  '관악구',
  '광진구',
  '구로구',
  '금천구',
  '노원구',
  '도봉구',
  '동대문구',
  '동작구',
  '마포구',
  '서대문구',
  '서초구',
  '성동구',
  '성북구',
  '송파구',
  '양천구',
  '영등포구',
  '용산구',
  '은평구',
  '종로구',
  '중구',
  '중랑구',
];