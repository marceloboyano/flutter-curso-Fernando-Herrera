import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;
  const ListaNoticias( this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index){


          return _Noticias(noticia:noticias[index], index: index);
      }
      );
  }
}


class _Noticias extends StatelessWidget {
  final Article noticia;
  final int index;
  const _Noticias({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia ),
        _TarjetaImagen(noticia ),
        _TarjetaBody(noticia ),
        const SizedBox(height: 10),
        const Divider(),
        _TarjetaBotones(),

      ],
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  Text((noticia.description != null )? noticia.description: '')
      
      
      );
    
  }
}
class _TarjetaBotones extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),       
            child: const Icon(Icons.star_border),     
            ),
            const SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.colorScheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),       
            child: const Icon(Icons.more),     
            )
        ],
      ),
    );
  }
}
class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;
  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
       child: Row(
        children: [
          Text('${index + 1} .', style: TextStyle(color:  miTema.colorScheme.secondary), ),
          Text('${noticia.source.name}.' ),
        ],
       ),
    );
  }
}


class _TarjetaTitulo extends StatelessWidget {
 final Article noticia;

  const _TarjetaTitulo( this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15) ,
      child: Text(noticia.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}


class _TarjetaImagen extends StatelessWidget {
 final Article noticia;

  const _TarjetaImagen( this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child:(noticia.urlToImage != null) 
              ? FadeInImage(
                placeholder: const AssetImage('assets/img/giphy.gif'),
                image: NetworkImage(noticia.urlToImage))
              : const Image(image: AssetImage('assets/img/no-image.png'))  ,
        ),
      ),
    );
  }
}