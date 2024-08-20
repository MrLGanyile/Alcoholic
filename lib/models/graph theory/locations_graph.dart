import 'dart:math';

import '../graph%20theory/unweigted_graph.dart';

import 'location.dart';
import 'section_name.dart';
import 'utilities.dart';
import 'graph.dart';
import 'edge.dart';

class LocationsGraph{

  // A connected graph - meaning there is a path between any two distinct vertices.
  Graph<Location>? graph;

  LocationsGraph(){

    List<Location> vertices = [
      Location(sectionName:  SectionName.umlaziA), // 0
      Location(sectionName:  SectionName.umlaziAA), // 1
      Location(sectionName:  SectionName.umlaziB), // 2
      Location(sectionName:  SectionName.umlaziBB), // 3
      Location(sectionName:  SectionName.umlaziC), // 4
      Location(sectionName:  SectionName.umlaziCC), // 5
      Location(sectionName:  SectionName.umlaziD), // 6
      Location(sectionName:  SectionName.umlaziE), // 7
      Location(sectionName:  SectionName.umlaziF), // 8
      Location(sectionName:  SectionName.umlaziG), // 9
      Location(sectionName:  SectionName.umlaziH), // 10
      Location(sectionName:  SectionName.umlaziJ), // 11
      Location(sectionName:  SectionName.umlaziK), // 12
      Location(sectionName:  SectionName.umlaziL), // 13
      Location(sectionName:  SectionName.umlaziM), // 14
      Location(sectionName:  SectionName.umlaziN), // 15
      Location(sectionName:  SectionName.umlaziQ), // 16
      Location(sectionName:  SectionName.umlaziR), // 17
      Location(sectionName:  SectionName.umlaziS), // 18
      Location(sectionName:  SectionName.umlaziU), // 19
      Location(sectionName:  SectionName.umlaziV), // 20
      Location(sectionName:  SectionName.umlaziW), // 21
      Location(sectionName:  SectionName.umlaziMalukazi), // 22
      Location(sectionName:  SectionName.umlaziY), // 23
      Location(sectionName:  SectionName.umlaziZ), // 24
      Location(sectionName:  SectionName.umlaziPhilani), // 25
    ];

    List<Edge> edges = [
      // Umlazi A neigbors   
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)),
      ),

      // Umlazi AA Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziCC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),


      // Umlazi B Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)),
      ),

      // Umlazi BB Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziCC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)),
      ),

      // Umlazi C Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ),

      // Umlazi CC Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziCC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziCC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziCC)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziK)),
      ),

      // Umlazi D Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ),

      // Umlazi E Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziF)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)),
      ),

      // Umlazi F Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziF)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziF)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziF)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziG)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziF)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ),

      // Umlazi G Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziG)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziF)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziG)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziG)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ),

      // Umlazi H Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziG)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziJ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ),

      // Umlazi J Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziJ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziJ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziJ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziK)),
      ),

      // Umlazi K Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziK)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziK)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziCC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziK)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziJ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziK)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),

      // Umlazi L Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziJ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziK)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ),

      // Umlazi M Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),

      // Umlazi N Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ),

      // Umlazi P Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),

      // Umlazi Q Neighbors
      
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ),// Note Vertex for "Umlazi R" Is Redundent For A Good Purpose.
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziS)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),

      // Umlazi R Neighbors 
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziL)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziN)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziP)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)),
      ),// Note Vertex for "Umlazi Q" Is Redundent For A Good Purpose.
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)),
      ), // Note Vertex for "Umlazi U" Is Redundent For A Good Purpose.
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ),

      // Umlazi S Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziS)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziS)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)),
      ),

      // Umlazi U Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ), // Note Vertex for "Umlazi R" Is Redundent For A Good Purpose.
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),

      // Umlazi V Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziE)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziS)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ), // Note Vertex for "Umlazi W" Is Redundent For A Good Purpose.

      // Umlazi W Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziC)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziD)),
      ),

      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziF)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziG)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziH)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziR)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziV)),
      ), // Note Vertex for "Umlazi V" Is Redundent For A Good Purpose.
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)),
      ),

      // Umlazi Malukazi Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziPhilani)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziW)),
      ), // Note Vertex for "Umlazi W"  Is Redundent For A Good Purpose.
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)),
      ), // Note Vertex for "Umlazi Y" Is Redundent For A Good Purpose.

      // Umlazi Y Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)),
      ), // Note Vertex for "Umlazi Malukazi" Is Redundent For A Good Purpose.
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),

      // Umlazi Z Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziAA)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziBB)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziM)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziQ)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziU)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziY)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziPhilani)),
      ),

      // Umlazi Philani Neighbors
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziPhilani)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziMalukazi)),
      ),
      Edge(
        vIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziPhilani)), 
        uIndex: Utilities.asIndex(Utilities.asString(SectionName.umlaziZ)),
      ),

    ];

    graph = UnweigtedGraph(vertices, edges);
  }

  // A connected graph - meaning there is a path between any two distinct vertices.
  static List<List<Location>> umlaziLocationsGraph = [
    
  ];

  
  static int findShortestDistanceBetweenSections(Location location1, Location location2){
    return Random().nextInt(10);
  }

  static Map<SectionName, bool> isSectionAdded = {
    SectionName.umlaziA:false, SectionName.umlaziAA:false, 
    SectionName.umlaziB:false, SectionName.umlaziBB:false, 
    SectionName.umlaziC:false, SectionName.umlaziCC:false,
    SectionName.umlaziD:false, SectionName.umlaziE:false, 
    SectionName.umlaziF:false, SectionName.umlaziG:false, 
    SectionName.umlaziH:false, SectionName.umlaziJ:false, 
    SectionName.umlaziK:false,SectionName.umlaziL:false, 
    SectionName.umlaziM:false, SectionName.umlaziN:false, 
    SectionName.umlaziP:false, SectionName.umlaziQ:false, 
    SectionName.umlaziR:false, SectionName.umlaziS:false,
    SectionName.umlaziU:false, SectionName.umlaziV:false, 
    SectionName.umlaziW:false, SectionName.umlaziMalukazi:false, 
    SectionName.umlaziY:false, SectionName.umlaziZ:false, 
    SectionName.umlaziPhilani:false
  };

  static Set<SectionName> orderSections(SectionName sectionName){
    
    Set<SectionName> sections = {};
    return orderSectionsHelper(sectionName, sections);
  }

  static Set<SectionName> orderSectionsHelper(SectionName sectionName, Set<SectionName> sections){

    if(sections.length==27){
      return sections;
    }

    // Add given section to the set.
    sections.add(sectionName);

    // Find the index of the given section.
    int findLocationIndex(SectionName sectionName){

    switch(sectionName){
      case SectionName.umlaziA: return 0;
      case SectionName.umlaziAA: return 1;
      case SectionName.umlaziB: return 2;
      case SectionName.umlaziBB: return 3;
      case SectionName.umlaziC: return 4;
      case SectionName.umlaziCC: return 5;
      case SectionName.umlaziD: return 6;
      case SectionName.umlaziE: return 7;
      case SectionName.umlaziF: return 8;
      case SectionName.umlaziG: return 9;
      case SectionName.umlaziH: return 10;
      case SectionName.umlaziJ: return 11;
      case SectionName.umlaziK: return 12;
      case SectionName.umlaziL: return 13;
      case SectionName.umlaziM: return 14;
      case SectionName.umlaziN: return 15;
      case SectionName.umlaziP: return 16;
      case SectionName.umlaziQ: return 17;
      case SectionName.umlaziR: return 18;
      case SectionName.umlaziS: return 19;
      case SectionName.umlaziU: return 20;
      case SectionName.umlaziV: return 21;
      case SectionName.umlaziW: return 22;
      case SectionName.umlaziMalukazi: return 23;
      case SectionName.umlaziY: return 24;
      case SectionName.umlaziZ: return 25;
      default: return 26;
    }
  }
    // List of all section neigbors.
    Set<String> neighbors = umlaziLocationsGraph[findLocationIndex(sectionName)] as Set<String>;
    
    
    // Add each neighbor to the set.
    for(String neighbor in neighbors){
      sections.add(Utilities.toSectionName(neighbor));
    }

    // Mark Section As Visited
    isSectionAdded[sectionName]==true;


    List<SectionName> sectionsAsList = sections as List<SectionName>;

    // Find next unvisited section in the set.
    for(int i = 0; i < sections.length;i++){
      if(isSectionAdded[sectionsAsList[i]]==false){
        return orderSectionsHelper(sectionsAsList[i],sections);
      }
    }

    return sections;
  }

}