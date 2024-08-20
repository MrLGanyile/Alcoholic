
import 'section_name.dart';

class Utilities{

  // Convert any section string to a section name constant.
  static SectionName toSectionName(String section){

    switch(section){
      case "Umlazi A": return SectionName.umlaziA;
      case "Umlazi AA": return SectionName.umlaziAA;
      case "Umlazi B": return SectionName.umlaziB;
      case "Umlazi BB": return SectionName.umlaziBB;
      case "Umlazi C": return SectionName.umlaziC;
      case "Umlazi CC": return SectionName.umlaziCC;
      case "Umlazi D": return SectionName.umlaziD;
      case "Umlazi E": return SectionName.umlaziE;
      case "Umlazi F": return SectionName.umlaziF;
      case "Umlazi G": return SectionName.umlaziG;
      case "Umlazi H": return SectionName.umlaziH;
      case "Umlazi J": return SectionName.umlaziJ;
      case "Umlazi K": return SectionName.umlaziK;
      case "Umlazi L": return SectionName.umlaziL;
      case "Umlazi M": return SectionName.umlaziM;
      case "Umlazi N": return SectionName.umlaziN;
      case "Umlazi P": return SectionName.umlaziP;
      case "Umlazi Q": return SectionName.umlaziQ;
      case "Umlazi R": return SectionName.umlaziR;
      case "Umlazi S": return SectionName.umlaziS;
      case "Umlazi U": return SectionName.umlaziU;
      case "Umlazi V": return SectionName.umlaziV;
      case "Umlazi W": return SectionName.umlaziW;
      case "Umlazi Malukazi": return SectionName.umlaziMalukazi;
      case "Umlazi Y": return SectionName.umlaziY;
      case "Umlazi Z": return SectionName.umlaziZ;
      default: return SectionName.umlaziPhilani;
    }
  }

  static String asString(SectionName sectionName){

  switch(sectionName){
    case SectionName.umlaziA: return 'Umlazi A';
    case SectionName.umlaziAA: return 'Umlazi AA';
    case SectionName.umlaziB: return 'Umlazi B';
    case SectionName.umlaziBB: return 'Umlazi BB';
    case SectionName.umlaziC: return 'Umlazi C';
    case SectionName.umlaziCC: return 'Umlazi CC';
    case SectionName.umlaziD: return 'Umlazi D';
    case SectionName.umlaziE: return 'Umlazi E';
    case SectionName.umlaziF: return 'Umlazi F';
    case SectionName.umlaziG: return 'Umlazi G';
    case SectionName.umlaziH: return 'Umlazi H';
    case SectionName.umlaziJ: return 'Umlazi J';
    case SectionName.umlaziK: return 'Umlazi K';
    case SectionName.umlaziL: return 'Umlazi L';
    case SectionName.umlaziM: return 'Umlazi M';
    case SectionName.umlaziN: return 'Umlazi N';
    case SectionName.umlaziP: return 'Umlazi P';
    case SectionName.umlaziQ: return 'Umlazi Q';
    case SectionName.umlaziR: return 'Umlazi R';
    case SectionName.umlaziS: return 'Umlazi S';
    case SectionName.umlaziU: return 'Umlazi U';
    case SectionName.umlaziV: return 'Umlazi V';
    case SectionName.umlaziW: return 'Umlazi W';
    case SectionName.umlaziMalukazi: return 'Umlazi (Malukazi)';
    case SectionName.umlaziY: return 'Umlazi Y';
    case SectionName.umlaziZ: return 'Umlazi Z';
    case SectionName.umlaziPhilani: return 'Umlazi (Philani)';
  }
}

  static SectionName asSectionName(int index){
    switch(index){
      case 0: return SectionName.umlaziA;
      case 1: return SectionName.umlaziAA;
      case 2: return SectionName.umlaziB;
      case 3: return SectionName.umlaziBB;
      case 4: return SectionName.umlaziC;
      case 5: return SectionName.umlaziCC;
      case 6: return SectionName.umlaziD;
      case 7: return SectionName.umlaziE;
      case 8: return SectionName.umlaziF;
      case 9: return SectionName.umlaziG;
      case 10: return SectionName.umlaziH;
      case 11: return SectionName.umlaziJ;
      case 12: return SectionName.umlaziK;
      case 13: return SectionName.umlaziL;
      case 14: return SectionName.umlaziM;
      case 15: return SectionName.umlaziN;
      case 16: return SectionName.umlaziP;
      case 17: return SectionName.umlaziQ;
      case 18: return SectionName.umlaziR;
      case 19: return SectionName.umlaziS;
      case 20: return SectionName.umlaziU;
      case 21: return SectionName.umlaziV;
      case 22: return SectionName.umlaziW;
      case 23: return SectionName.umlaziMalukazi;
      case 24: return SectionName.umlaziY;
      case 25: return SectionName.umlaziZ;
      default: return SectionName.umlaziPhilani;
      
    }
  }
  
  static int asIndex(String sectionName){
    switch(sectionName){
      case 'Umlazi A': return 0;
      case 'Umlazi AA': return 1;
      case 'Umlazi B': return 2;
      case 'Umlazi BB': return 3;
      case 'Umlazi C': return 4;
      case 'Umlazi CC': return 5;
      case 'Umlazi D': return 6;
      case 'Umlazi E': return 7;
      case 'Umlazi F': return 8;
      case 'Umlazi G': return 9;
      case 'Umlazi H': return 10;
      case 'Umlazi J': return 11;
      case 'Umlazi K': return 12;
      case 'Umlazi L': return 13;
      case 'Umlazi M': return 14;
      case 'Umlazi N': return 15;
      case 'Umlazi P': return 16;
      case 'Umlazi Q': return 17;
      case 'Umlazi R': return 18;
      case 'Umlazi S': return 19;
      case 'Umlazi U': return 20;
      case 'Umlazi V': return 21;
      case 'Umlazi W': return 22;
      case 'Umlazi Malukazi': return 23;
      case 'Umlazi Y': return 24;
      case 'Umlazi Z': return 25;
      default: return 26;
      
    }
  }

}