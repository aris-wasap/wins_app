import 'package:flutter/material.dart';

class InventoryTransfer extends StatefulWidget {
  @override
  _InventoryTransferState createState() => _InventoryTransferState();
}

class _InventoryTransferState extends State<InventoryTransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Transfer"),
        backgroundColor: Colors.blue[900],
        bottom: PreferredSize(
          child: Container(
            color: Colors.yellow[900], height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)
        )
      ),
    );
  }
}