import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:toko_manager/model/brand.dart';

import 'package:toko_manager/model/category.dart';
import 'package:toko_manager/model/fire_user.dart';
import 'package:toko_manager/model/product.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;
  Product product = new Product();
  FireUser _user = new FireUser();

  List<dynamic> brandsDynamic = [];
  List<String> brandsList;

  List<dynamic> categoriesDynamic = [];
  List<String> categoriesList;

  @override
  void initState() {
    getBrandsList();
    getCategoriesList();
    print(categoriesList);
    super.initState();
  }

  void getBrandsList() {
    firestore
        .collection('dropdown_lists')
        .doc('brands')
        .get()
        .then((value) => brandsDynamic.addAll(value.get("brand_names")));

    brandsList = brandsDynamic.cast<String>();
    // print(brandsDynamic);
    // print(brandsList);

    // firestore.collection('brands').get().then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     brandsList.add(doc["brand_name"]);
    //   });
    // });
  }

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
                TextButton(
                  onPressed: () => updateData(documentSnapshot),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                  //color: Colors.green,
                ),
                SizedBox(width: 8),
                TextButton(
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
          onSaved: (value) => product.name = value,
        ),
        // Autocomplete Docs: https://www.woolha.com/tutorials/flutter-using-autocomplete-widget-examples
        Autocomplete<Brand>(
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<Brand> onSelected,
              Iterable<Brand> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  // width: 300,
                  // color: Colors.teal,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Brand option = options.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(
                            option.name,
                            //style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            Iterable<Brand> brandIterable = brandsList.where((String option) {
              return option.contains(textEditingValue.text.toLowerCase());
            }).map((brand) => Brand(brand, true));

            if (brandIterable.isEmpty) {
              return [Brand(textEditingValue.text, false)];
            } else {
              return brandIterable;
            }
          },
          displayStringForOption: (Brand option) => option.name,
          onSelected: (Brand selection) => product.brand = selection,
        ),

        Autocomplete<Category>(
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<Category> onSelected,
              Iterable<Category> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  // width: 300,
                  // color: Colors.teal,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Category option = options.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(
                            option.name,
                            //style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            Iterable<Category> categoryIterable =
                categoriesList.where((String option) {
              return option.contains(textEditingValue.text.toLowerCase());
            }).map((category) => Category(category, true));

            if (categoryIterable.isEmpty) {
              return [Category(textEditingValue.text, false)];
            } else {
              return categoryIterable;
            }
          },
          displayStringForOption: (Category option) => option.name,
          onSelected: (Category selection) => product.category = selection,
        ),
        // TextFormField(
        //   decoration: InputDecoration(
        //     border: InputBorder.none,
        //     hintText: 'category',
        //     fillColor: Colors.grey[300],
        //     filled: true,
        //   ),
        //   validator: (value) {
        //     if (value.isEmpty) {
        //       return 'Please enter some text';
        //     }
        //   },
        //   onSaved: (value) => product.category = value.toLowerCase(),
        // ),
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
          onSaved: (value) => product.supplierPrice = int.parse(value),
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
          onSaved: (value) => product.retailPrice = int.parse(value),
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
      onSaved: (value) => product.name = value.toLowerCase(),
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
                  onPressed: () async {
                    createData();
                    showDialog<String>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Barang Berhasil Ditambahkan!'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
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

  Future<AlertDialog> createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference reference = await firestore.collection('products').add({
        'name': '${product.name.toLowerCase()}',
        'brand': '${product.brand.name.toLowerCase()}',
        'category': '${product.category.name.toLowerCase()}',
        'supplierPrice': product.supplierPrice,
        'retailPrice': product.retailPrice,
        'createdOn': Timestamp.now(),
        'lastEditedOn': null,
        'createdBy': '${_user.displayName}',
        'createdByUid': '${_user.uid}',
        'lastEditedBy': null,
      });
      setState(() => id = reference.id);

      if (product.brand.isExist == false) {
        await firestore.collection('dropdown_lists').doc('brands').update({
          'brand_names':
              FieldValue.arrayUnion([product.brand.name.toLowerCase()])
        });
      }

      if (product.category.isExist == false) {
        await firestore.collection('dropdown_lists').doc('categories').update({
          'category_names':
              FieldValue.arrayUnion([product.category.name.toLowerCase()])
        });
      }
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
        .update({'name': '$product.name'});
  }

  void deleteData(DocumentSnapshot documentSnapshot) async {
    await firestore.collection('products').doc(documentSnapshot.id).delete();
    setState(() => id = null);
  }
}
