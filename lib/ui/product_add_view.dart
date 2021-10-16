import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_drawer.dart';

class ProductAddView extends StatefulWidget {
  ProductAddView({Key key}) : super(key: key);

  @override
  _ProductAddViewState createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView> {
  String id;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String name;
  String brand;
  String category;
  int supplierPrice;
  int retailPrice;
  List<String> brandsList;

  List<String> buildBrandsList() {
    return brandsList = ['hitachi', 'samsung'];
  }

  Card buildItem(DocumentSnapshot documentSnapshot) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              documentSnapshot.data()['name'],
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => updateData(documentSnapshot),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => deleteData(documentSnapshot),
                  child: Text('Delete'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'name',
            fillColor: Colors.grey[300],
            filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          onSaved: (value) => name = value,
        ),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: buildBrandsList(),
            label: "Brand",
            hint: "country in menu mode",
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            selectedItem: "samsung"),
        // TextFormField(
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     hintText: 'brand',
        //     fillColor: Colors.grey[300],
        //     filled: true,
        //   ),
        //   validator: (value) {
        //     if (value.isEmpty) {
        //       return 'Please enter some text';
        //     }
        //   },
        //   onSaved: (value) => brand = value,
        // ),
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'category',
            fillColor: Colors.grey[300],
            filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          onSaved: (value) => category = value,
        ),
        TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'supplierPrice',
            fillColor: Colors.grey[300],
            filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          onSaved: (value) => supplierPrice = int.parse(value),
        ),
        TextFormField(
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'retailPrice',
            fillColor: Colors.grey[300],
            filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          onSaved: (value) => retailPrice = int.parse(value),
        ),
      ],
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'name',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: HomeDrawer(),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Form(
              key: _formKey,
              child: buildForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: createData,
                  child: Text('Create', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                RaisedButton(
                  onPressed: id != null ? readData : null,
                  child: Text('Read', style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      children: snapshot.data.docs
                          .map((document) => buildItem(document))
                          .toList());
                } else {
                  return SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference reference = await firestore.collection('products').add({
        'name': '$name',
        'brand': '$brand',
        'category': '$category',
        'supplierPrice': supplierPrice,
        'retailPrice': retailPrice
      });
      setState(() => id = reference.id);
      print(reference.id);
    }
  }

  void readData() async {
    DocumentSnapshot snapshot =
        await firestore.collection('products').doc(id).get();
    print(snapshot.data()['name']);
  }

  void updateData(DocumentSnapshot documentSnapshot) async {
    await firestore
        .collection('products')
        .doc(documentSnapshot.id)
        .update({'name': '$name'});
  }

  void deleteData(DocumentSnapshot documentSnapshot) async {
    await firestore.collection('products').doc(documentSnapshot.id).delete();
    setState(() => id = null);
  }
}
