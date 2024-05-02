// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class WorldMapExample extends StatefulWidget {
//   const WorldMapExample({super.key});
//
//   @override
//   State<WorldMapExample> createState() => _WorldMapExampleState();
// }
//
// class _WorldMapExampleState extends State<WorldMapExample> {
//
//   List<String> greenCountries = []; // List of countries to color green
//   MapController mapController = MapController();
//
//   // Sample API endpoint for demonstration
//   final String apiUrl = 'https://restcountries.com/v2/all';
//
//   // Fetch country data from API
//   Future<void> fetchCountryData() async {
//     final response = await http.get(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as List<dynamic>;
//       // Extract country data and update greenCountries list
//       setState(() {
//         greenCountries = data.map((country) => country['name'] as String).toList();
//       });
//     } else {
//       throw Exception('Failed to load country data');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCountryData(); // Fetch data when the app starts
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var marker = <Marker>[
//       Marker(
//         point: LatLng(23.777176, 90.399452),
//         child: Icon(Icons.pin_drop,color: Colors.green),
//       ),
//       Marker(
//         point: LatLng(51.169392, 71.449074),
//         child: Icon(Icons.pin_drop,color: Colors.blue,),
//       ),
//       Marker(
//         point: LatLng(55.751244, 37.618423),
//         child: Icon(Icons.pin_drop,color: Colors.pink,),
//       ),
//     ];
//     return SafeArea(
//         child: Scaffold(
//           body: Center(
//             child: Container(
//               child: Column(
//                 children: [
//                   Flexible(
//                     child: FlutterMap(
//                       options: MapOptions(
//                         initialCenter: LatLng(23.777176, 90.399452),
//                         initialZoom: 5,
//                       ),
//                       children: [
//                         TileLayer(
//                           urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                           subdomains: ['a','b','c'],
//                         ),
//                         MarkerLayer(
//                             markers: marker,
//                         ),
//                       ],
//                     )
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }
//
//   // Build polygons for countries
//   List<Polygon> buildPolygons() {
//     List<Polygon> polygons = [];
//     for (var countryName in greenCountries) {
//       // Sample coordinates for demonstration (for the purpose of this example)
//       List<LatLng> countryCoordinates = [
//         LatLng(0, 0),
//         LatLng(0, 10),
//         LatLng(10, 10),
//         LatLng(10, 0),
//       ];
//       polygons.add(
//         Polygon(
//           points: countryCoordinates,
//           color: Colors.green.withOpacity(0.5), // Green color with opacity
//           borderStrokeWidth: 1,
//           borderColor: Colors.green,
//         ),
//       );
//     }
//     return polygons;
//   }
// }
