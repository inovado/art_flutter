
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:art_flutter/particle.dart';
import 'my_painter_canvas.dart';

class MyPainter extends StatefulWidget {
  MyPainter({Key key}) : super(key: key); 

  
  @override
  _MyPainterState createState() => _MyPainterState();
}

Color getRamdomColor(Random rgn){

  var a = rgn.nextInt(255);
  var r = rgn.nextInt(255);
  var g = rgn.nextInt(255);
  var b = rgn.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}


double maxRadius = 6;
double maxSpeed = 0.2;
double maxTheta = 2.0 * pi;


//EL CODIGO PARA ANIMAR SE SEÑALARA CON *** Y se comentara lo que se vaya agregando

class _MyPainterState extends State<MyPainter> with SingleTickerProviderStateMixin { //*** 
//class _MyPainterState extends State<MyPainter> { 
 
 // LISTA DE PARTICULAR
  List<Particle> particulas;
  Animation<double> animation; // ***
  AnimationController controller; // ***
  
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch); // random para color aleatorio
  
  
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 10)); // ***
    animation = Tween<double>(begin: 0, end: 300).animate(controller) // ***
      ..addListener(() { // ***
        setState(() { // ***
          
        }); // ***
      }) // ***
      ..addStatusListener((status){ // ***
        if (status == AnimationStatus.completed) { // ***
          controller.repeat(); // ***
        } else if (status == AnimationStatus.dismissed) { // ***
          controller.forward(); // ***
        } // ***
      }); // ***

      controller.forward(); // ***

    //inicializacion de particular
    this.particulas = List.generate(200, (index) {  // list de 10 particular
      var p = Particle();
      p.color = getRamdomColor(rgn);
      p.position = Offset(-1, -1);
      p.speed = rgn.nextDouble() * maxSpeed;  // 0 -> 0.2
      p.theta = rgn.nextDouble() * maxRadius; // 0 -> 2pi radians
      p.radius = rgn.nextDouble() * maxRadius  ;

      return p;
    });
  
  @override // ***
  void dispose(){ // ***
    controller.dispose(); // ***
    super.dispose(); // ***
  } // ***

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        child: Container(), painter: MyPainterCanvas(rgn, particulas, animation.value)));
        //child: Container(), painter: MyPainterCanvas(rgn, particulas,)));
  }
}
        

