import 'package:flutter/material.dart';
import 'package:toko_manager/ui/inventory_view.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('(Account Name)'),
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
        ],
      ),
    );
  }
}
