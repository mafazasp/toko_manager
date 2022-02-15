import 'package:flutter/material.dart';
import 'package:toko_manager/ui/home_drawer.dart';

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
  List<String> cart = ["product 1", "product 2"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: HomeDrawer(),
        body: Container(
          child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cart[index]),
                );
              }),
        ),
      ),
    );
  }
}
