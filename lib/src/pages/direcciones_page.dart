


import 'package:flutter/material.dart';
import 'package:qareaderapp/src/bloc/scan_bloc.dart';
import 'package:qareaderapp/src/models/scan_nodel.dart';
import 'package:qareaderapp/src/utils/utils.dart' as utils;
// import 'package:qareaderapp/src/providers/db_provider.dart';

class DireccionesPage extends StatelessWidget {
   final scanBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
scanBloc.obtenerScans();

    return StreamBuilder <List<ScanModel>>(
      stream: scanBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text('No hay informaciòn'),
          );
        } else {
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) =>
             Dismissible(
               key:UniqueKey() ,
               background: Container(color: Colors.red,),
               onDismissed: (direccion) => {
                 print('id a eliminar ${scans[i].id}'),
                 scanBloc.borrarScan(scans[i].id)

                 
               },
              child: ListTile(
                onTap: (){

                 utils. abrirScan(context, scans[i]);
                },
                leading: Icon(Icons.cloud_queue,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[i].valor),
                subtitle:Text('${scans[i].id}') ,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
