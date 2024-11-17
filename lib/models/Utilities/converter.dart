import '../section_name.dart';
import '../stores/store_draw_state.dart';

class Converter {
  static StoreDrawState toStoreDrawState(String state) {
    switch (state) {
      case "converted-to-competition":
        return StoreDrawState.convertedToCompetition;
      case "playing-competition":
        return StoreDrawState.playingCompetition;
      case "competition-finished":
        return StoreDrawState.competitionFinished;
      default:
        return StoreDrawState.notConvertedToCompetition;
    }
  }

  static String fromStoreDrawStateToString(StoreDrawState storeDrawState) {
    switch (storeDrawState) {
      case StoreDrawState.convertedToCompetition:
        return "converted-to-competition";
      case StoreDrawState.playingCompetition:
        return "playing-competition";
      case StoreDrawState.competitionFinished:
        return "competition-finished";
      default:
        return "not-converted-to-competition";
    }
  }

  // Convert any section string to a section name constant.
  static SectionName toSectionName(String section) {
    switch (section) {
      case "Cato Manor-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.catoManorMayvilleDurbanKwaZuluNatalSouthAfrica;
      case "Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.dunbarMayvilleDurbanKwaZuluNatalSouthAfrica;
      case "Masxha-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.masxhaMayvilleDurbanKwaZuluNatalSouthAfrica;
      case "Bonela-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.bonelaMayvilleDurbanKwaZuluNatalSouthAfrica;
      case "Sherwood-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.sherwoodMayvilleDurbanKwaZuluNatalSouthAfrica;
      case "Richview-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.richviewMayvilleDurbanKwaZuluNatalSouthAfrica;
      case "Nsimbini-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.nsimbiniMayvilleDurbanKwaZuluNatalSouthAfrica;
      case "Manor Gardens-Mayville-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.manorGardensMayvilleDurbanKwaZuluNatalSouthAfrica;

      case 'A Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziADurbanKwaZuluNatalSouthAfrica;
      case 'AA Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziAADurbanKwaZuluNatalSouthAfrica;
      case 'B Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziBDurbanKwaZuluNatalSouthAfrica;
      case 'BB Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziBBDurbanKwaZuluNatalSouthAfrica;
      case 'C Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziCDurbanKwaZuluNatalSouthAfrica;
      case 'CC Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziCCDurbanKwaZuluNatalSouthAfrica;
      case 'D Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziDDurbanKwaZuluNatalSouthAfrica;
      case 'E Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziEDurbanKwaZuluNatalSouthAfrica;
      case 'F Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziFDurbanKwaZuluNatalSouthAfrica;
      case 'G Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziGDurbanKwaZuluNatalSouthAfrica;
      case 'H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziHDurbanKwaZuluNatalSouthAfrica;
      case 'J Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziJDurbanKwaZuluNatalSouthAfrica;
      case 'K Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziKDurbanKwaZuluNatalSouthAfrica;
      case 'L Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziLDurbanKwaZuluNatalSouthAfrica;
      case 'M Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziMDurbanKwaZuluNatalSouthAfrica;
      case 'N Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziNDurbanKwaZuluNatalSouthAfrica;
      case 'P Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziPDurbanKwaZuluNatalSouthAfrica;
      case 'Q Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziQDurbanKwaZuluNatalSouthAfrica;
      case 'R Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziRDurbanKwaZuluNatalSouthAfrica;
      case 'S Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziSDurbanKwaZuluNatalSouthAfrica;
      case 'U Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziUDurbanKwaZuluNatalSouthAfrica;
      case 'V Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziVDurbanKwaZuluNatalSouthAfrica;
      case 'W Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziWDurbanKwaZuluNatalSouthAfrica;
      case 'Y Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziYDurbanKwaZuluNatalSouthAfrica;
      case 'Z Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziZDurbanKwaZuluNatalSouthAfrica;
      case 'Malukazi-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziMalukaziDurbanKwaZuluNatalSouthAfrica;
      case 'Philani-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.umlaziPhilaniDurbanKwaZuluNatalSouthAfrica;
      case "MUT-Umlazi-Kwa Zulu Natal-South Africa":
        return SectionName.mutUmlaziDurbanKwaZuluNatalSouthAfrica;

      case "Haward College Campus-UKZN-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.hawardCollegeCampusUKZNDurbanKwaZuluNatalSouthAfrica;
      case "Westville Campus-UKZN-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.westvilleCampusUKZNDurbanKwaZuluNatalSouthAfrica;
      case "Edgewood Campus-UKZN-Pinetown-Kwa Zulu Natal-South Africa":
        return SectionName.edgewoodCampusUKZNPinetownKwaZuluNatalSouthAfrica;

      case "Steve Biko Campus-DUT-Durban-Kwa Zulu Natal-South Africa":
        return SectionName.steveBikoCampusDutDurbanKwaZuluNatalSouthAfrica;

      default:
        return SectionName.catoCrestMayvilleDurbanKwaZuluNatalSouthAfrica;
    }
  }

  static String asString(SectionName sectionName) {
    switch (sectionName) {
      // ==============================Mayville==============================
      case SectionName.catoManorMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Cato Manor-Mayville-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.dunbarMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Dunbar-Mayville-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.masxhaMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Masxha-Mayville-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.bonelaMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Bonela-Mayville-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.sherwoodMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Sherwood-Mayville-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.richviewMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Richview-Mayville-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.nsimbiniMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Nsimbini-Mayville-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.manorGardensMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Manor Gardens-Mayville-Durban-Kwa Zulu Natal-South Africa';

      // ==============================Umlazi==============================
      case SectionName.umlaziADurbanKwaZuluNatalSouthAfrica:
        return 'A Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziAADurbanKwaZuluNatalSouthAfrica:
        return 'AA Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziBDurbanKwaZuluNatalSouthAfrica:
        return 'B Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziBBDurbanKwaZuluNatalSouthAfrica:
        return 'BB Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziCDurbanKwaZuluNatalSouthAfrica:
        return 'C Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziCCDurbanKwaZuluNatalSouthAfrica:
        return 'CC Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziDDurbanKwaZuluNatalSouthAfrica:
        return 'D Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziEDurbanKwaZuluNatalSouthAfrica:
        return 'E Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziFDurbanKwaZuluNatalSouthAfrica:
        return 'F Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziGDurbanKwaZuluNatalSouthAfrica:
        return 'G Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziHDurbanKwaZuluNatalSouthAfrica:
        return 'H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziJDurbanKwaZuluNatalSouthAfrica:
        return 'J Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziKDurbanKwaZuluNatalSouthAfrica:
        return 'K Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziLDurbanKwaZuluNatalSouthAfrica:
        return 'L Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziMDurbanKwaZuluNatalSouthAfrica:
        return 'M Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziNDurbanKwaZuluNatalSouthAfrica:
        return 'N Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziPDurbanKwaZuluNatalSouthAfrica:
        return 'P Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziQDurbanKwaZuluNatalSouthAfrica:
        return 'Q Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziRDurbanKwaZuluNatalSouthAfrica:
        return 'R Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziSDurbanKwaZuluNatalSouthAfrica:
        return 'S Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziUDurbanKwaZuluNatalSouthAfrica:
        return 'U Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziVDurbanKwaZuluNatalSouthAfrica:
        return 'V Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziWDurbanKwaZuluNatalSouthAfrica:
        return 'W Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziYDurbanKwaZuluNatalSouthAfrica:
        return 'Y Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziZDurbanKwaZuluNatalSouthAfrica:
        return 'Z Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziMalukaziDurbanKwaZuluNatalSouthAfrica:
        return 'Malukazi-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.umlaziPhilaniDurbanKwaZuluNatalSouthAfrica:
        return 'Philani-Umlazi-Durban-Kwa Zulu Natal-South Africa';

      // ===================Tertiary Students=========================
      case SectionName.mutUmlaziDurbanKwaZuluNatalSouthAfrica:
        return "MUT-Umlazi-Durban-Kwa Zulu Natal-South Africa";
      case SectionName.hawardCollegeCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return "Haward College Campus-UKZN-Durban-Kwa Zulu Natal-South Africa";
      case SectionName.westvilleCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return "Westville Campus-UKZN-Durban-Kwa Zulu Natal-South Africa";
      case SectionName.edgewoodCampusUKZNPinetownKwaZuluNatalSouthAfrica:
        return "Edgewood Campus-UKZN-Pinetown-Kwa Zulu Natal-South Africa";

      case SectionName.steveBikoCampusDutDurbanKwaZuluNatalSouthAfrica:
        return "Steve Biko Campus-DUT-Durban-Kwa Zulu Natal-South Africa";
      default:
        return 'Cato Crest-Mayville-Durban-Kwa Zulu Natal-South Africa';
    }
  }

  static SectionName asSectionName(int index) {
    switch (index) {
      case 0:
        return SectionName.catoManorMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 1:
        return SectionName.dunbarMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 2:
        return SectionName.masxhaMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 3:
        return SectionName.bonelaMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 4:
        return SectionName.sherwoodMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 5:
        return SectionName.sherwoodMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 6:
        return SectionName.richviewMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 7:
        return SectionName.nsimbiniMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 8:
        return SectionName.manorGardensMayvilleDurbanKwaZuluNatalSouthAfrica;
      case 9:
        return SectionName.umlaziADurbanKwaZuluNatalSouthAfrica;
      case 10:
        return SectionName.umlaziAADurbanKwaZuluNatalSouthAfrica;
      case 11:
        return SectionName.umlaziBDurbanKwaZuluNatalSouthAfrica;
      case 12:
        return SectionName.umlaziBBDurbanKwaZuluNatalSouthAfrica;
      case 13:
        return SectionName.umlaziCDurbanKwaZuluNatalSouthAfrica;
      case 14:
        return SectionName.umlaziCCDurbanKwaZuluNatalSouthAfrica;
      case 15:
        return SectionName.umlaziADurbanKwaZuluNatalSouthAfrica;
      case 16:
        return SectionName.umlaziEDurbanKwaZuluNatalSouthAfrica;
      case 17:
        return SectionName.umlaziFDurbanKwaZuluNatalSouthAfrica;
      case 18:
        return SectionName.umlaziGDurbanKwaZuluNatalSouthAfrica;
      case 19:
        return SectionName.umlaziHDurbanKwaZuluNatalSouthAfrica;
      case 20:
        return SectionName.umlaziJDurbanKwaZuluNatalSouthAfrica;
      case 21:
        return SectionName.umlaziKDurbanKwaZuluNatalSouthAfrica;
      case 22:
        return SectionName.umlaziLDurbanKwaZuluNatalSouthAfrica;
      case 23:
        return SectionName.umlaziMDurbanKwaZuluNatalSouthAfrica;
      case 24:
        return SectionName.umlaziNDurbanKwaZuluNatalSouthAfrica;
      case 25:
        return SectionName.umlaziPDurbanKwaZuluNatalSouthAfrica;
      case 26:
        return SectionName.umlaziQDurbanKwaZuluNatalSouthAfrica;
      case 27:
        return SectionName.umlaziRDurbanKwaZuluNatalSouthAfrica;
      case 28:
        return SectionName.umlaziSDurbanKwaZuluNatalSouthAfrica;
      case 29:
        return SectionName.umlaziUDurbanKwaZuluNatalSouthAfrica;
      case 30:
        return SectionName.umlaziVDurbanKwaZuluNatalSouthAfrica;
      case 31:
        return SectionName.umlaziWDurbanKwaZuluNatalSouthAfrica;
      case 32:
        return SectionName.umlaziYDurbanKwaZuluNatalSouthAfrica;
      case 33:
        return SectionName.umlaziZDurbanKwaZuluNatalSouthAfrica;
      case 34:
        return SectionName.umlaziMalukaziDurbanKwaZuluNatalSouthAfrica;
      case 35:
        return SectionName.umlaziPhilaniDurbanKwaZuluNatalSouthAfrica;
      case 36:
        return SectionName.mutUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 37:
        return SectionName.hawardCollegeCampusUKZNDurbanKwaZuluNatalSouthAfrica;
      case 38:
        return SectionName.westvilleCampusUKZNDurbanKwaZuluNatalSouthAfrica;
      case 39:
        return SectionName.edgewoodCampusUKZNPinetownKwaZuluNatalSouthAfrica;
      case 40:
        return SectionName.steveBikoCampusDutDurbanKwaZuluNatalSouthAfrica;
      default:
        return SectionName.catoCrestMayvilleDurbanKwaZuluNatalSouthAfrica;
    }
  }
}
