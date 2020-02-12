import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ncf_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';

class BarcodeScan extends StatefulWidget {
  @override
  State createState() => new BarcodeScanState();
}

class BarcodeScanState extends State<BarcodeScan>{
  String result = "Scan now";
  Future _scanQR() async{
    try{
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    }on PlatformException catch(ex){
      if(ex.code==BarcodeScanner.CameraAccessDenied){
        setState(() {
          result = "Camera permition was denied";
        });
      }
      else{
        setState(() {
          result = "Unknown error $ex";
        });
      }
    } on FormatException{
      setState(() {
       result = "You press back button before scan"; 
      });
    } catch (ex){
      setState(() {
        result = "Unknown error $ex";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Barcode Scanner"),
        backgroundColor: Colors.blue[900],
        bottom: PreferredSize(
          child: Container(
            color: Colors.yellow[900], height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xfff9fbe7), const Color(0xffd7ccc8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: Center(
          child: Text(
            result,
            style: new TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        backgroundColor: Colors.orange[700],
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}