import 'dart:async';


import 'package:qareaderapp/src/bloc/validator.dart';
import 'package:qareaderapp/src/models/scan_nodel.dart';
import 'package:qareaderapp/src/providers/db_provider.dart';

class ScansBloc with validators{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }
  ScansBloc._internal() {
    //obterner los scans de la base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();
  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
 Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);


  dispose() {
    _scansController?.close();
  }


  obtenerScans()async{

    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }


 obtenerScans2()async{

    _scansController.sink.add(await DBProvider.db.getTodosScansService());
  }

borrarScan(int id) async{
await DBProvider.db.deleteScan(id);
obtenerScans();

}


borrarScanTodos() async {
  await DBProvider.db.deleteAll();
  obtenerScans();
}

agregarScan(ScanModel scan) async{

await DBProvider.db.nuevoScanService(scan);

 obtenerScans2();

}
}
