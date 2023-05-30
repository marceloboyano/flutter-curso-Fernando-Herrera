


import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan (String valor) async{
    final nuevoScan = new ScanModel(valor:valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //Asignar el id de la base de datos al modelo
    nuevoScan.id = id;
    
    if(tipoSeleccionado == nuevoScan.tipo){

       scans.add(nuevoScan);
       notifyListeners();
    }

  }

}