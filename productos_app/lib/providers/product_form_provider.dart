

import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductFormPorvider extends ChangeNotifier{

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

     Product product;

     ProductFormPorvider(this.product);

     updateAvailability(bool value){
      product.available = value;
      notifyListeners();
     }
    

    bool isValidForm(){

      return formKey.currentState?.validate()?? false;
    }

}