import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//Widget que muestra una sección con título y un slider horizontal de objetos
class CategorySlider extends StatelessWidget {
  final String title; //Título de la sección
  final List<dynamic> items; //Lista de objetos que se van a mostrar
  final String type; //Tipo de objeto
  final Function(dynamic) onTap; //Función que se ejecuta al pulsar un elemento

  const CategorySlider({
    required this.title,
    required this.items,
    required this.type,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Si no hay elementos, no muestra nada
    if (items.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        //Título de la categoría
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
        ),

        //Slider horizontal con las tarjetas
        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 10),

              //Muestra máximo 20 elementos para no saturar el slider
              for (var i = 0; i < items.length; i++)
                if (i < 20)
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      //Al pulsar -> ejecuta la función onTap con el objeto
                      onTap: () => onTap(items[i]),
                      child: SizedBox(
                        width: 140,
                        child: Column(
                          children: [
                            //Imagen del objeto
                            Container(
                              height: 160,
                              width: 140,
                              color: Colors.grey[800],
                              child: CachedNetworkImage(
                                imageUrl: items[i].image ?? '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(color: Colors.amber),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 50,
                                ),
                              ),
                            ),

                            SizedBox(height: 8),

                            //Nombre del objeto
                            Text(
                              items[i].name ?? 'Sin nombre',
                              style: TextStyle(color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

              SizedBox(width: 10),
            ],
          ),
        ),

        //Espacio inferior entre secciones (margen inferior)
        SizedBox(height: 20),
      ],
    );
  }
}