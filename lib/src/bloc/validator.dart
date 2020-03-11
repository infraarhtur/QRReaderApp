import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qareaderapp/src/models/scan_nodel.dart';

class validators {
  final validarGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(

    handleData: (scans ,sink){

      final geoScans = scans.where((s)=> s.tipo == 'geo').toList();
      sink.add(geoScans);

    }
  );


  final validarHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(

    handleData: (scans ,sink){

      final httpScans = scans.where((s)=> s.tipo == 'http').toList();
      sink.add(httpScans);

    }
  );





}