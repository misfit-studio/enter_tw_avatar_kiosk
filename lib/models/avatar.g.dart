// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AvatarImpl _$$AvatarImplFromJson(Map<String, dynamic> json) => _$AvatarImpl(
      head: $enumDecode(_$AvatarHeadEnumMap, json['head']),
      torso: $enumDecode(_$AvatarTorsoEnumMap, json['torso']),
      arms: $enumDecode(_$AvatarArmsEnumMap, json['arms']),
      legs: $enumDecode(_$AvatarLegsEnumMap, json['legs']),
    );

Map<String, dynamic> _$$AvatarImplToJson(_$AvatarImpl instance) =>
    <String, dynamic>{
      'head': _$AvatarHeadEnumMap[instance.head]!,
      'torso': _$AvatarTorsoEnumMap[instance.torso]!,
      'arms': _$AvatarArmsEnumMap[instance.arms]!,
      'legs': _$AvatarLegsEnumMap[instance.legs]!,
    };

const _$AvatarHeadEnumMap = {
  AvatarHead.vrHeadset: 'vrHeadset',
  AvatarHead.gameboy: 'gameboy',
  AvatarHead.snesHomeConsole: 'snesHomeConsole',
  AvatarHead.odysseyPongArcade: 'odysseyPongArcade',
  AvatarHead.vloggingCamera: 'vloggingCamera',
  AvatarHead.iMac: 'iMac',
  AvatarHead.fax: 'fax',
  AvatarHead.wallTelephone: 'wallTelephone',
  AvatarHead.smartwatch: 'smartwatch',
  AvatarHead.iPod: 'iPod',
  AvatarHead.walkman: 'walkman',
  AvatarHead.grammophone: 'grammophone',
};

const _$AvatarTorsoEnumMap = {
  AvatarTorso.iPhone: 'iPhone',
  AvatarTorso.flipPhone: 'flipPhone',
  AvatarTorso.cordlessPhone: 'cordlessPhone',
  AvatarTorso.transistorRadio: 'transistorRadio',
  AvatarTorso.smartSpeaker: 'smartSpeaker',
  AvatarTorso.gamerPC: 'gamerPC',
  AvatarTorso.stereoSystem: 'stereoSystem',
  AvatarTorso.tapePlayerReel: 'tapePlayerReel',
  AvatarTorso.arduino: 'arduino',
  AvatarTorso.motor: 'motor',
  AvatarTorso.walkieTalkie: 'walkieTalkie',
  AvatarTorso.vacuumTube: 'vacuumTube',
};

const _$AvatarArmsEnumMap = {
  AvatarArms.human: 'human',
  AvatarArms.humanWithSmartwatch: 'humanWithSmartwatch',
  AvatarArms.humanWithGameboy: 'humanWithGameboy',
  AvatarArms.humanWithCamera: 'humanWithCamera',
  AvatarArms.mechArm: 'mechArm',
  AvatarArms.pcPeripheralArms: 'pcPeripheralArms',
  AvatarArms.recordingEquipmentArms: 'recordingEquipmentArms',
};

const _$AvatarLegsEnumMap = {
  AvatarLegs.singleLegVideoGaming: 'singleLegVideoGaming',
  AvatarLegs.singleLegProductivity: 'singleLegProductivity',
  AvatarLegs.singleLegCreative: 'singleLegCreative',
  AvatarLegs.twoLegsVideoGaming: 'twoLegsVideoGaming',
  AvatarLegs.twoLegsProductivity: 'twoLegsProductivity',
  AvatarLegs.twoLegsCreative: 'twoLegsCreative',
  AvatarLegs.manyLegsVideoGaming: 'manyLegsVideoGaming',
  AvatarLegs.manyLegsProductivity: 'manyLegsProductivity',
  AvatarLegs.manyLegsCreative: 'manyLegsCreative',
};
