import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:toko_manager/model/brand.dart';

import 'package:toko_manager/model/category.dart';
import 'package:toko_manager/model/fire_user.dart';
import 'package:toko_manager/model/product.dart';

class ProductFiller {}

List<String> globalList = ['hello', 'world'];

String id;
final _formKey = GlobalKey<FormState>();
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
Product product = new Product();
FireUser _user = new FireUser();

List<dynamic> brandsDynamic = [];
List<String> brandsList;

List<dynamic> categoriesDynamic = [];
List<String> categoriesList;

void getCategoriesList() {
  firestore
      .collection('dropdown_lists')
      .doc('categories')
      .get()
      .then((value) => categoriesDynamic.addAll(value.get("category_names")));

  categoriesList = categoriesDynamic.cast<String>();
  // print(categoriesDynamic);
  // print(brandsDynamic);
}
