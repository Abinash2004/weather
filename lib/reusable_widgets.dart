//import 'dart:js';
import 'package:flutter/material.dart';

Widget weatherContainer1(temp,sky) {
  return SizedBox(
    width: double.infinity,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: const Color.fromARGB(255, 30, 33, 36),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('$temp K',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 181, 181, 181),
              ),
            ),
            const SizedBox(height: 20),
            checkIcon1(sky),
            const SizedBox(height: 20,),
            Text(sky,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 181, 181, 181),
              ),
            ),
          ],
        ),
      ),
    ),
  ); 
}

Widget checkIcon1(sky) {

  if(sky == 'Rain'){
    return const Icon(Icons.snowing,
            color: Color.fromARGB(255, 181, 181, 181),
            size: 75,);
  }
  else if(sky == 'Clear'){
    return const Icon(Icons.sunny,
            color: Color.fromARGB(255, 181, 181, 181),
            size: 75,);
  }
  return const Icon(Icons.cloud,
            color: Color.fromARGB(255, 181, 181, 181),
            size: 75,);

}
Widget checkIcon2(sky) {

  if(sky == 'Rain'){
    return const Icon(Icons.snowing,
            color: Color.fromARGB(255, 181, 181, 181),
            size: 25,);
  }
  else if(sky == 'Clear'){
    return const Icon(Icons.sunny,
            color: Color.fromARGB(255, 181, 181, 181),
            size: 25,);
  }
  return const Icon(Icons.cloud,
            color: Color.fromARGB(255, 181, 181, 181),
            size: 25,);

}

Widget weatherContainer2(var screen, sky, time, desc) {
  return SizedBox(
    width: screen.width * 0.29,
    height: screen.height * 0.18,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color.fromARGB(255, 30, 33, 36),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: screen.height*0.0025),
            Text(time,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                 color: Color.fromARGB(255, 181, 181, 181),
              ),
            ),
            SizedBox(height: screen.height*0.02),
            checkIcon2(sky),
            SizedBox(height: screen.height*0.02),
            Text('$desc K',
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 181, 181, 181),
              ),
            ),
          ],
        ),
       ),
    ),
  );
}

Widget weatherContainer3(var screen, icon, category,desc) {
  return SizedBox(
    width: screen.width * 0.29,
    height: screen.height * 0.2,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color.fromARGB(255, 30, 33, 36),
      child: Column(
        children: [
          SizedBox(height: screen.height*0.02),
          Icon(icon,size: 25,color: Colors.white,),
          SizedBox(height: screen.height*0.025),
          Text(category,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 181, 181, 181),
            ),
          ),
          SizedBox(height: screen.height*0.025),
          Text(desc,
            style: const TextStyle(
              fontSize: 22.5,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 181, 181, 181),
            ),
          ),
        ],
      ),
    ),
  );
}
Container searchButton(bool name,Function onTap) {
  return Container(
    width: 100,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration:  BoxDecoration(
      borderRadius: BorderRadius.circular(90)
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black;
          }
          return const Color.fromARGB(255, 0, 37, 62);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(name?'Back':'Set',
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold, 
          fontSize: 15,
        ),
      ),
    ),
  );
}
