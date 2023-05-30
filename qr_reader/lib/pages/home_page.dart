import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).borratTodos();
            }, 
            icon: const Icon(Icons.delete_forever))
        ],
      ),
      body:  _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
        floatingActionButton: const ScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}



class _HomePageBody extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    //obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    //cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //usar el scanlistProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

//TEMPORAL PARA IR PROBANDO  LAS CONSULTAS EN LA BASE DE DATOS
   // final tempScan = ScanModel(valor:'http:/google.com');
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getScanById(7).then((scan) => print(scan!.valor));
   //DBProvider.db.getTodosLosScans().then(print);
   

    switch(currentIndex){
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
         return const MapasPage();
      case 1:
        scanListProvider.cargarScanPorTipo('http');
         return const DireccionesPage();
      default:
      return const MapasPage();
    }
  }
}