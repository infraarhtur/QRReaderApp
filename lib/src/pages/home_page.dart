import 'package:flutter/material.dart';
import 'package:qareaderapp/src/bloc/scan_bloc.dart';
import 'package:qareaderapp/src/models/scan_nodel.dart';
import 'package:qareaderapp/src/pages/direcciones_page.dart';
import 'package:qareaderapp/src/pages/mapas_page.dart';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qareaderapp/src/utils/utils.dart' as utils;
// import 'package:qareaderapp/src/providers/db_provider.dart';
// import 'package:qareaderapp/src/models/scan_nodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scanBloc = new ScansBloc();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.delete_forever,
              ),
              onPressed: () {
                scanBloc.borrarScanTodos();
              })
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottonNavitionBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearBottonNavitionBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
    );
  }

  _scanQR(BuildContext context) async {
    String futureString; //='https://periferiaitgroup.com/';

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
futureString = e.toString();

    }

    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      // final scan2 = ScanModel(valor:'geo:4.6831128,-74.0523874');
      scanBloc.agregarScan(scan);
// scanBloc.agregarScan(scan2);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {
        utils.abrirScan(context, scan);
      }

// scanBloc.agregarScan(scan2);
    }

// try {
//   futureString =await BarcodeScanner.scan();
// } catch (e) {
//   futureString = e.toString();
// }

// print('Future String: $futureString');

// if(futureString != null){
//   print('Tenemos informaciòn');
// }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();

      default:
        MapasPage();
    }
  }
}
