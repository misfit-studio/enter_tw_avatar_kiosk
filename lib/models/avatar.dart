import 'package:enter_bravo_kiosk/models/questionnaire.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar.freezed.dart';
part 'avatar.g.dart';

enum AvatarHead {
  vrHeadset,
  gameboy,
  snesHomeConsole,
  odysseyPongArcade,
  vloggingCamera,
  iMac,
  fax,
  wallTelephone,
  smartwatch,
  iPod,
  walkman,
  grammophone,
}

extension AvatarHeadExtension on AvatarHead {
  String get attachmentName => switch (this) {
        AvatarHead.vrHeadset => "HEADS/H01_VRHEADSET",
        AvatarHead.gameboy => "HEADS/H02_GAMEBOY 1",
        AvatarHead.snesHomeConsole => "HEADS/H03_CONSOLE_80S",
        AvatarHead.odysseyPongArcade => "HEADS/H04_CONSOLE_70S",
        AvatarHead.vloggingCamera => "HEADS/H05_VLOG_CAMERA",
        AvatarHead.iMac => "HEADS/H06_IMAC",
        AvatarHead.fax => "HEADS/H07_FAX 1",
        AvatarHead.wallTelephone => "HEADS/H08_WALL_PHONE",
        AvatarHead.smartwatch => "HEADS/H09_SMARTWATCH",
        AvatarHead.iPod => "HEADS/H10_IPOD",
        AvatarHead.walkman => "HEADS/H11_WALKMAN",
        AvatarHead.grammophone => "HEADS/H12_GRAMMO",
      };
}

enum AvatarTorso {
  iPhone,
  flipPhone,
  cordlessPhone,
  transistorRadio,
  smartSpeaker,
  gamerPC,
  stereoSystem,
  tapePlayerReel,
  arduino,
  motor,
  walkieTalkie,
  vacuumTube,
}

extension AvatarTorsoExtension on AvatarTorso {
  String get attachmentName => switch (this) {
        AvatarTorso.iPhone => "TORSO/T01_IPHONE",
        AvatarTorso.flipPhone => "TORSO/T02_FLIP_PHONE_2",
        AvatarTorso.cordlessPhone => "TORSO/T03_CORDLESS_PHONE",
        AvatarTorso.transistorRadio => "TORSO/T04_TR_RADIO",
        AvatarTorso.smartSpeaker => "TORSO/T05_ALEXA",
        AvatarTorso.gamerPC => "TORSO/T06_GAMER_PC",
        AvatarTorso.stereoSystem => "TORSO/T07_STEREO_SYSTEM",
        AvatarTorso.tapePlayerReel => "TORSO/T08_REEL_TAPE",
        AvatarTorso.arduino => "TORSO/T09_ARDUINO",
        AvatarTorso.motor => "TORSO/T10_MOTOR",
        AvatarTorso.walkieTalkie => "TORSO/T11_WALKIETALKIE",
        AvatarTorso.vacuumTube => "TORSO/T12_VACUUM_TUBE",
      };
}

enum AvatarArms {
  human,
  humanWithSmartwatch,
  humanWithGameboy,
  humanWithCamera,
  mechArm,
  pcPeripheralArms,
  recordingEquipmentArms,
}

extension AvatarArmsExtension on AvatarArms {
  String getPartAttachmentName(String armSide, String armDir) {
    // Attachment names look like ARMS/SW_R_ARM_DOWN
    return "ARMS/${attachmentName}_${armSide}_$armDir";
  }

  String get attachmentName => switch (this) {
        AvatarArms.human => "A01_HUMAN",
        AvatarArms.humanWithSmartwatch => "A02_H_SMARTWATCH",
        AvatarArms.humanWithGameboy => "A03_H_GAMEBOY",
        AvatarArms.humanWithCamera => "A04_H_CAMERA",
        AvatarArms.mechArm => "A05_MECH",
        AvatarArms.pcPeripheralArms => "A06_PC_ARMS",
        AvatarArms.recordingEquipmentArms => "A07_MIC_ARMS",
      };
}

enum AvatarLegs {
  singleLegVideoGaming,
  singleLegProductivity,
  singleLegCreative,
  twoLegsVideoGaming,
  twoLegsProductivity,
  twoLegsCreative,
  manyLegsVideoGaming,
  manyLegsProductivity,
  manyLegsCreative,
}

extension AvatarLegsExtension on AvatarLegs {
  String get leftThighAttachment => switch (this) {
        AvatarLegs.twoLegsVideoGaming => "LEGS/L04_TWO_GAMING_L_UP",
        AvatarLegs.twoLegsProductivity => "LEGS/L05_TWO_PC_L_UP",
        AvatarLegs.twoLegsCreative => "LEGS/L06_TWO_CREATIVE_L_UP",
        AvatarLegs.manyLegsVideoGaming => "LEGS/L07_MANY_GAMING_L",
        AvatarLegs.manyLegsProductivity => "LEGS/L08_MANY_PC_L",
        AvatarLegs.manyLegsCreative => "LEGS/L09_MANY_CREATIVE_L",
        _ => "",
      };

  String get leftShinAttachment => switch (this) {
        AvatarLegs.twoLegsVideoGaming => "LEGS/L04_TWO_GAMING_L_DOWN",
        AvatarLegs.twoLegsProductivity => "LEGS/L05_TWO_PC_L_DOWN",
        AvatarLegs.twoLegsCreative => "LEGS/L06_TWO_CREATIVE_L_DOWN",
        _ => "",
      };

  String get leftFootAttachment => switch (this) {
        AvatarLegs.twoLegsVideoGaming => "LEGS/L04_TWO_GAMING_L_FOOT",
        AvatarLegs.twoLegsProductivity => "LEGS/L05_TWO_PC_L_FOOT",
        AvatarLegs.twoLegsCreative => "LEGS/L06_TWO_CREATIVE_L_FOOT",
        _ => "",
      };

  String get rightThighAttachment => switch (this) {
        AvatarLegs.twoLegsVideoGaming => "LEGS/L04_TWO_GAMING_R_UP",
        AvatarLegs.twoLegsProductivity => "LEGS/L05_TWO_PC_R_UP",
        AvatarLegs.twoLegsCreative => "LEGS/L06_TWO_CREATIVE_R_UP",
        AvatarLegs.manyLegsVideoGaming => "LEGS/L07_MANY_GAMING_R",
        AvatarLegs.manyLegsProductivity => "LEGS/L08_MANY_PC_R",
        AvatarLegs.manyLegsCreative => "LEGS/L09_MANY_CREATIVE_R",
        _ => "",
      };

  String get rightShinAttachment => switch (this) {
        AvatarLegs.twoLegsVideoGaming => "LEGS/L04_TWO_GAMING_R_DOWN",
        AvatarLegs.twoLegsProductivity => "LEGS/L05_TWO_PC_R_DOWN",
        AvatarLegs.twoLegsCreative => "LEGS/L06_TWO_CREATIVE_R_DOWN",
        _ => "",
      };

  String get rightFootAttachment => switch (this) {
        AvatarLegs.twoLegsVideoGaming => "LEGS/L04_TWO_GAMING_R_FOOT",
        AvatarLegs.twoLegsProductivity => "LEGS/L05_TWO_PC_R_FOOT",
        AvatarLegs.twoLegsCreative => "LEGS/L06_TWO_CREATIVE_R_FOOT",
        _ => "",
      };

  String get unicycleStemAttachment => switch (this) {
        AvatarLegs.singleLegVideoGaming => "LEGS/L01_SINGLE_GAMING_STEM",
        AvatarLegs.singleLegProductivity => "LEGS/L02_SINGLE_PC_STEM",
        AvatarLegs.singleLegCreative => "LEGS/L03_SINGLE_CREATIVE_STEM",
        _ => "",
      };

  String get unicycleWheelAttachment => switch (this) {
        AvatarLegs.singleLegVideoGaming => "LEGS/L01_SINGLE_GAMING_WHEEL",
        AvatarLegs.singleLegProductivity => "LEGS/L02_SINGLE_PC_WHEEL",
        AvatarLegs.singleLegCreative => "LEGS/L03_SINGLE_CREATIVE_WHEEL",
        _ => "",
      };
}

@freezed
class Avatar with _$Avatar {
  const factory Avatar({
    required AvatarHead head,
    required AvatarTorso torso,
    required AvatarArms arms,
    required AvatarLegs legs,
  }) = _Avatar;

  factory Avatar.fromQuestionnaire(Questionnaire profile) {
    if (!profile.isCompleted) {
      throw Exception("Cannot create avatar from incomplete questionnaire");
    }

    final head = switch (profile.interestType) {
      InterestType.play => switch (profile.generation) {
          Generation.babyboomer => AvatarHead.odysseyPongArcade,
          Generation.genX => AvatarHead.snesHomeConsole,
          Generation.genY => AvatarHead.gameboy,
          Generation.genZ => AvatarHead.vrHeadset,
          _ => throw Exception("Invalid generation"),
        },
      InterestType.utility => switch (profile.generation) {
          Generation.babyboomer => AvatarHead.wallTelephone,
          Generation.genX => AvatarHead.fax,
          Generation.genY => AvatarHead.iMac,
          Generation.genZ => AvatarHead.smartwatch,
          _ => throw Exception("Invalid generation"),
        },
      InterestType.creativity => switch (profile.generation) {
          Generation.babyboomer => AvatarHead.grammophone,
          Generation.genX => AvatarHead.walkman,
          Generation.genY => AvatarHead.iPod,
          Generation.genZ => AvatarHead.vloggingCamera,
          _ => throw Exception("Invalid generation"),
        },
      _ => throw Exception("Invalid interest type"),
    };

    final torso = switch (profile.proficiency) {
      Proficiency.casual => switch (profile.generation) {
          Generation.babyboomer => AvatarTorso.transistorRadio,
          Generation.genX => AvatarTorso.cordlessPhone,
          Generation.genY => AvatarTorso.flipPhone,
          Generation.genZ => AvatarTorso.iPhone,
          _ => throw Exception("Invalid generation"),
        },
      Proficiency.interested => switch (profile.generation) {
          Generation.babyboomer => AvatarTorso.tapePlayerReel,
          Generation.genX => AvatarTorso.stereoSystem,
          Generation.genY => AvatarTorso.gamerPC,
          Generation.genZ => AvatarTorso.smartSpeaker,
          _ => throw Exception("Invalid generation"),
        },
      Proficiency.nerd => switch (profile.generation) {
          Generation.babyboomer => AvatarTorso.vacuumTube,
          Generation.genX => AvatarTorso.walkieTalkie,
          Generation.genY => AvatarTorso.motor,
          Generation.genZ => AvatarTorso.arduino,
          _ => throw Exception("Invalid generation"),
        },
      _ => throw Exception("Invalid proficiency"),
    };

    final arms = switch (profile.reliance) {
      Reliance.low => AvatarArms.human,
      Reliance.moderate => switch (profile.interestType) {
          InterestType.play => AvatarArms.humanWithGameboy,
          InterestType.utility => AvatarArms.humanWithSmartwatch,
          InterestType.creativity => AvatarArms.humanWithCamera,
          _ => throw Exception("Invalid interest type"),
        },
      Reliance.high => switch (profile.interestType) {
          InterestType.play => AvatarArms.mechArm,
          InterestType.utility => AvatarArms.pcPeripheralArms,
          InterestType.creativity => AvatarArms.recordingEquipmentArms,
          _ => throw Exception("Invalid interest type"),
        },
      _ => throw Exception("Invalid reliance"),
    };

    final legs = switch (profile.broadness) {
      Broadness.limited => switch (profile.interestType) {
          InterestType.play => AvatarLegs.singleLegVideoGaming,
          InterestType.utility => AvatarLegs.singleLegProductivity,
          InterestType.creativity => AvatarLegs.singleLegCreative,
          _ => throw Exception("Invalid broadness"),
        },
      Broadness.diverse => switch (profile.interestType) {
          InterestType.play => AvatarLegs.twoLegsVideoGaming,
          InterestType.utility => AvatarLegs.twoLegsProductivity,
          InterestType.creativity => AvatarLegs.twoLegsCreative,
          _ => throw Exception("Invalid interest type"),
        },
      Broadness.broad => switch (profile.interestType) {
          InterestType.play => AvatarLegs.manyLegsVideoGaming,
          InterestType.utility => AvatarLegs.manyLegsProductivity,
          InterestType.creativity => AvatarLegs.manyLegsCreative,
          _ => throw Exception("Invalid interest type"),
        },
      _ => throw Exception("Invalid broadness"),
    };

    return Avatar(
      head: head,
      torso: torso,
      arms: arms,
      legs: legs,
    );
  }

  const Avatar._();

  @override
  String toString() {
    return "Avatar($head | $torso | $arms | $legs)";
  }

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
}
