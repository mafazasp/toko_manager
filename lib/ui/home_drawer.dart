import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_manager/model/fire_user.dart';
import 'package:toko_manager/net/authentication_service.dart';
import 'package:toko_manager/ui/inventory_view.dart';

import 'product_add_view.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FireUser _user = new FireUser();

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(_user.displayName),
          ),
          ListTile(
            title: Text('Barang'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventoryView(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Tambah Barang'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductAddView(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Keluar"),
            onTap: () {
              context.read<AuthenticationService>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
