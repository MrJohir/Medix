import 'package:flutter/material.dart';

// Enum for Protocol Locations (Filter Tabs)
enum ProtocolLocation { all, uk, us, eu, me, ca, nz }

extension ProtocolLocationExtension on ProtocolLocation {
  String get value {
    switch (this) {
      case ProtocolLocation.all:
        return 'All';
      case ProtocolLocation.uk:
        return 'UK';
      case ProtocolLocation.us:
        return 'US';
      case ProtocolLocation.eu:
        return 'EU';
      case ProtocolLocation.me:
        return 'ME';
      case ProtocolLocation.ca:
        return 'CA';
      case ProtocolLocation.nz:
        return 'NZ';
    }
  }

  String get displayName {
    switch (this) {
      case ProtocolLocation.all:
        return 'All Regions';
      case ProtocolLocation.uk:
        return 'United Kingdom';
      case ProtocolLocation.us:
        return 'United States';
      case ProtocolLocation.eu:
        return 'European Union';
      case ProtocolLocation.me:
        return 'Middle East';
      case ProtocolLocation.ca:
        return 'Canada';
      case ProtocolLocation.nz:
        return 'New Zealand';
    }
  }

  static ProtocolLocation fromString(String value) {
    switch (value.toUpperCase()) {
      case 'UK':
        return ProtocolLocation.uk;
      case 'US':
        return ProtocolLocation.us;
      case 'EU':
        return ProtocolLocation.eu;
      case 'ME':
        return ProtocolLocation.me;
      case 'CA':
        return ProtocolLocation.ca;
      case 'NZ':
        return ProtocolLocation.nz;
      default:
        return ProtocolLocation.all;
    }
  }
}

// Enum for Protocol Categories
// ignore: constant_identifier_names
enum ProtocolCategory {
  allCategories,
  emergency,
  botulinumToxin,
  allergicReactions,
  dermalFillers,
  anesthetics,
  vascularComplications,
  postProcedureCare,
}

extension ProtocolCategoryExtension on ProtocolCategory {
  String get value {
    switch (this) {
      case ProtocolCategory.allCategories:
        return 'All Categories';
      case ProtocolCategory.emergency:
        return 'Emergency';
      case ProtocolCategory.botulinumToxin:
        return 'Botulinum Toxin';
      case ProtocolCategory.allergicReactions:
        return 'Allergic Reactions';
      case ProtocolCategory.dermalFillers:
        return 'Dermal Fillers';
      case ProtocolCategory.anesthetics:
        return 'Anesthetics';
      case ProtocolCategory.vascularComplications:
        return 'Vascular Complications';
      case ProtocolCategory.postProcedureCare:
        return 'Post-Procedure Care';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ProtocolCategory.allCategories:
        return const Color(0xFFF9E7E8);
      case ProtocolCategory.emergency:
        return const Color(0xFFF9E7E8);
      case ProtocolCategory.botulinumToxin:
        return const Color(0xFFE7F3FF);
      case ProtocolCategory.allergicReactions:
        return const Color(0xFFF0F9FF);
      case ProtocolCategory.dermalFillers:
        return const Color(0xFFFFF7E6);
      case ProtocolCategory.anesthetics:
        return const Color(0xFFE7F3FF);
      case ProtocolCategory.vascularComplications:
        return const Color(0xFFF0F9FF);
      case ProtocolCategory.postProcedureCare:
        return const Color(0xFFFFF7E6);
    }
  }

  Color get textColor {
    switch (this) {
      case ProtocolCategory.allCategories:
        return const Color(0xFFD32F2F);
      case ProtocolCategory.emergency:
        return const Color(0xFFD32F2F);
      case ProtocolCategory.botulinumToxin:
        return const Color(0xFF1976D2);
      case ProtocolCategory.allergicReactions:
        return const Color(0xFF0288D1);
      case ProtocolCategory.dermalFillers:
        return const Color(0xFFF57C00);
      case ProtocolCategory.anesthetics:
        return const Color(0xFF1976D2);
      case ProtocolCategory.vascularComplications:
        return const Color(0xFF0288D1);
      case ProtocolCategory.postProcedureCare:
        return const Color(0xFFF57C00);
    }
  }

  static ProtocolCategory fromString(String value) {
    switch (value.toLowerCase().trim()) {
      case 'emergency':
      case 'emergence':
        return ProtocolCategory.emergency;
      case 'procedure':
        return ProtocolCategory
            .allCategories; // Map procedure to allCategories since it's test data
      case 'botulinum toxin':
      case 'botulinumtoxin':
        return ProtocolCategory.botulinumToxin;
      case 'allergic reactions':
      case 'allergicreactions':
        return ProtocolCategory.allergicReactions;
      case 'dermal fillers':
      case 'dermalfillers':
        return ProtocolCategory.dermalFillers;
      case 'anesthetics':
        return ProtocolCategory.anesthetics;
      case 'vascular complications':
      case 'vascularcomplications':
        return ProtocolCategory.vascularComplications;
      case 'post-procedure care':
      case 'postprocedurecare':
        return ProtocolCategory.postProcedureCare;
      default:
        return ProtocolCategory.allCategories;
    }
  }
}

// Enum for Protocol Priority
enum ProtocolPriority { low, medium, high, empty }

extension ProtocolPriorityExtension on ProtocolPriority {
  String get value {
    switch (this) {
      case ProtocolPriority.low:
        return 'Low Priority';
      case ProtocolPriority.medium:
        return 'Medium Priority';
      case ProtocolPriority.high:
        return 'High Priority';
      case ProtocolPriority.empty:
        return 'No Priority';
    }
  }

  Color get color {
    switch (this) {
      case ProtocolPriority.low:
        return const Color(0xFF28A745);
      case ProtocolPriority.medium:
        return const Color(0xFFFFC107);
      case ProtocolPriority.high:
        return const Color(0xFFDC3545);
      case ProtocolPriority.empty:
        return const Color(0xFF6C757D);
    }
  }

  static ProtocolPriority fromString(String value) {
    switch (value.toLowerCase().trim().replaceAll('_', ' ')) {
      case 'low priority':
      case 'low':
      case '1':
        return ProtocolPriority.low;
      case 'medium priority':
      case 'medium':
      case '2':
        return ProtocolPriority.medium;
      case 'high priority':
      case 'high':
      case '3':
        return ProtocolPriority.high;
      default:
        return ProtocolPriority.empty;
    }
  }
}
