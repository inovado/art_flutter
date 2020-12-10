import 'dart:math';

import 'package:flutter/material.dart';

import 'package:art_flutter/particle.dart';


//velocidad polar a cartesiana
Offset polarToCartesian(double speed, double theta){
  return Offset(speed * cos(theta), speed*sin(theta));
}

class MyPainterCanvas extends CustomPainter {
  List<Particle> particulas;
  Random rgn;
  double animValue; // ***
  //MyPainterCanvas(this.rgn, this.particulas ); // lista de particulas que se dibujaran, viene de "my_painter.dart"
  MyPainterCanvas(this.rgn, this.particulas, this.animValue); // ***

  @override
  void paint(Canvas canvas, Size size) {
    // update the objects
    this.particulas.forEach((p) { //posicionando particulas dentro del canvas de manera aleatoria
      var velocidad = polarToCartesian(p.speed, p.theta);
      var dx = p.position.dx + velocidad.dx;
      var dy = p.position.dy + velocidad.dy;

      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }

      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);

    });


    //paint the objects
    this.particulas.forEach((p) { //ciclo para pintar particulas
      var paint = Paint();
      paint.color = Colors.red;
      canvas.drawCircle(p.position, p.radius, paint);
   
    });

//PRIMER CIRCULO PARA DIBUJAR
      // var dx = size.width/2;
      // var dy = size.height/2;

      // var c = Offset(dx, dy);
      // var radius = 10.0;
      // var paint = Paint();
      // paint.color = Colors.red;
      // canvas.drawCircle(c, radius, paint);

  }
  @override
  bool shouldRepaint(CustomPainter o) {
  return true;    
  }
    
}