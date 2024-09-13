import '../../section_name.dart';

class Converter {
  // Convert any section string to a section name constant.
  static SectionName toSectionName(String section) {
    switch (section) {
      case "Dunbar Mayville Durban KZN South Africa":
        return SectionName.dunbarMayvilleDurbanKwaZuluNatalSouthAfrica;
      default:
        return SectionName.catoCrestMayvilleDurbanKwaZuluNatalSouthAfrica;
    }
  }

  static String asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.dunbarMayvilleDurbanKwaZuluNatalSouthAfrica:
        return 'Dunbar-Mayville-Durban-KZN-South Africa';
      default:
        return 'Cato Crest-Mayville-Durban-KZN-South Africa';
    }
  }

  static SectionName asSectionName(int index) {
    switch (index) {
      case 0:
        return SectionName.catoCrestMayvilleDurbanKwaZuluNatalSouthAfrica;
      default:
        return SectionName.dunbarMayvilleDurbanKwaZuluNatalSouthAfrica;
    }
  }

  static int asIndex(String sectionName) {
    switch (sectionName) {
      case 'Cato Crest Mayville Durban KZN South Africa':
        return 0;
      default:
        return 1;
    }
  }
}
