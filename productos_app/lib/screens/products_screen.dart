import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return  ChangeNotifierProvider(
     create: (_ ) => ProductFormPorvider( productsService.selectedProduct),
     child:  _ProductsScreenBody(productsService: productsService),);    
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    super.key,
    required this.productsService,
  });

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormPorvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
    //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag, // oculta el teclado cuando se mueve o scrolea 
        child: Column(
          children: [
            Stack(
              children: [
                 ProductImage(url: productsService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,size: 40, color: Colors.white), 
                    onPressed: () => Navigator.of(context).pop(),                  
                    ),
                  ),
                  Positioned(
                  top: 60,
                  right: 40,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined,size: 40, color: Colors.white), 
                    onPressed: () async {
                      final picker = ImagePicker();
                     final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 100,
                    );
                      if(pickedFile == null){
                         print('No seleccionó nada');
                        return;
                      }

                      //   print('Tenemos imagen ${pickedFile.path}');
                         productsService.updateSelectedProductImage(pickedFile.path);

                    },                  
                    ),
                  )
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 150),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(       
        onPressed: productsService.isSaving
        ? null
        : () async {
          if(!productForm.isValidForm()) return;

          final String? imageUrl = await productsService.uploadImage();
          
          if(imageUrl != null) {
            productForm.product.picture = imageUrl;
          }

          await productsService.saveOrCreateProduct(productForm.product);
        },
        child: productsService.isSaving
        ? const CircularProgressIndicator(color: Colors.white)
        : const Icon(Icons.save_outlined)
         ),
      );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormPorvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,         
          decoration: _builBoxDecoration(),
          child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) =>product.name = value,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                  },
                    decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del Producto',
                      labelText: 'Nombre:'
                    ),
                ),
                const SizedBox(height: 30),

                 TextFormField(
                   initialValue: '${product.price}',
                   inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                   ],
                  onChanged: (value) {
                      if(double.tryParse(value) == null){
                        product.price = 0;

                      }else{
                        product.price = double.parse(value);
                      }
                  },                 
                  keyboardType: TextInputType.number,
                    decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150',
                      labelText: 'Precio:'
                    ),
                ),
               
                     const SizedBox(height: 30),

                     SwitchListTile.adaptive(
                      value: product.available, 
                      title: const Text('Disponible'),
                      activeColor: Colors.indigo,
                      onChanged: (value) => productForm.updateAvailability(value)
                       
                     ),
                     const SizedBox(height: 30),
              ],
            ),
          ),
        ),      
    );
  }

  BoxDecoration _builBoxDecoration() =>  BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
    boxShadow: [BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 5),
      blurRadius: 5
    )]
  );
}