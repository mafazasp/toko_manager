import 'package:flutter/material.dart';
import 'package:toko_manager/model/product.dart';
import 'package:toko_manager/model/product_mock.dart';
import 'package:toko_manager/net/product_filler.dart';
import 'package:toko_manager/ui/home_drawer.dart';
import 'package:toko_manager/ui/product_add_view.dart';
import 'package:toko_manager/model/category.dart';

class InventoryAddView extends StatefulWidget {
  InventoryAddView({Key key}) : super(key: key);

  @override
  _InventoryAddViewState createState() => _InventoryAddViewState();
}

class _InventoryAddViewState extends State<InventoryAddView> {
  //inventory_add_form{
  // product cart;
  // int quantity;
  // int total_price;
  // int extra_costs;
  // string payment_method;
  // string added_by;
  // string supplier_name;
  // bool paid;
  //
  // if product_name does not exist in products collection:
  //  showProductAddPopupForm() {
  //    #similar to product_add_view
  //    add data to products
  //    redirect back to the inventory_add_view
  // if product_name exist:
  // }

  final _formKey = GlobalKey<FormState>();
  final productFiller = ProductFiller();

  Product product1 = Product();
  Product product2 = Product();
  List<Product> cart = [];

  @override
  void initState() {
    product1.name = "Product One";
    product2.name = "Product Two";
    cart.add(product1);
    cart.add(product2);
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: HomeDrawer(),
        body: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(cart[index].name),
                      trailing: TextButton(
                        onPressed: () => {
                          setState(() {
                            cart.removeAt(index);
                          })
                        },
                        child: Text("X"),
                      ));
                }),
          ),
          Text('Testing'),
          // Autocomplete<Category>(
          //   optionsViewBuilder: (BuildContext context,
          //       AutocompleteOnSelected<Category> onSelected,
          //       Iterable<Category> options) {
          //     return Align(
          //       alignment: Alignment.topLeft,
          //       child: Material(
          //         child: Container(
          //           // width: 300,
          //           // color: Colors.teal,
          //           child: ListView.builder(
          //             padding: EdgeInsets.all(10.0),
          //             itemCount: options.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               final Category option = options.elementAt(index);

          //               return GestureDetector(
          //                 onTap: () {
          //                   onSelected(option);
          //                 },
          //                 child: ListTile(
          //                   title: Text(
          //                     option.name,
          //                     //style: const TextStyle(color: Colors.white),
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          //   optionsBuilder: (TextEditingValue textEditingValue) {
          //     Iterable<Category> categoryIterable =
          //         productFiller.categoriesList.where((String option) {
          //       return option.contains(textEditingValue.text.toLowerCase());
          //     }).map((category) => Category(category, true));

          //     if (categoryIterable.isEmpty) {
          //       return [Category(textEditingValue.text, false)];
          //     } else {
          //       return categoryIterable;
          //     }
          //   },
          //   displayStringForOption: (Category option) => option.name,
          //   onSelected: (Category selection) =>
          //       product1.category = selection, //product.category = selection,
          // ),
        ]),
      ),
    );
  }
}
