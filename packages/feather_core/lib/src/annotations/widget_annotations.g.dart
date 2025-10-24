// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_annotations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageMeta _$PageMetaFromJson(Map<String, dynamic> json) => PageMeta(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => FileMeta.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  selfFiles:
      (json['selfFiles'] as List<dynamic>?)
          ?.map((e) => FileMeta.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  types: (json['types'] as List<dynamic>)
      .map((e) => $enumDecode(_$PageTypeEnumMap, e))
      .toList(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => $enumDecode(_$PageCategoryEnumMap, e))
      .toList(),
  screens: (json['screens'] as List<dynamic>)
      .map((e) => $enumDecode(_$ScreensEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$PageMetaToJson(PageMeta instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'files': instance.files,
  'selfFiles': instance.selfFiles,
  'types': instance.types.map((e) => _$PageTypeEnumMap[e]!).toList(),
  'categories': instance.categories
      .map((e) => _$PageCategoryEnumMap[e]!)
      .toList(),
  'screens': instance.screens.map((e) => _$ScreensEnumMap[e]!).toList(),
};

const _$PageTypeEnumMap = {
  PageType.formPage: 'formPage',
  PageType.feedPage: 'feedPage',
  PageType.dashboardPage: 'dashboardPage',
  PageType.detailPage: 'detailPage',
  PageType.listPage: 'listPage',
  PageType.mediaPage: 'mediaPage',
  PageType.onboardingPage: 'onboardingPage',
  PageType.authPage: 'authPage',
  PageType.checkoutPage: 'checkoutPage',
  PageType.landingPage: 'landingPage',
  PageType.layout: 'layout',
};

const _$PageCategoryEnumMap = {
  PageCategory.pageCategoty: 'pageCategoty',
  PageCategory.auth: 'auth',
  PageCategory.onboarding: 'onboarding',
  PageCategory.social: 'social',
  PageCategory.ecommerce: 'ecommerce',
  PageCategory.dashboard: 'dashboard',
  PageCategory.productivity: 'productivity',
  PageCategory.media: 'media',
  PageCategory.miscellaneous: 'miscellaneous',
};

const _$ScreensEnumMap = {
  Screens.mobile: 'mobile',
  Screens.tablet: 'tablet',
  Screens.desktop: 'desktop',
};

BlockMeta _$BlockMetaFromJson(Map<String, dynamic> json) => BlockMeta(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => FileMeta.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  selfFiles:
      (json['selfFiles'] as List<dynamic>?)
          ?.map((e) => FileMeta.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  types: (json['types'] as List<dynamic>)
      .map((e) => $enumDecode(_$BlockTypeEnumMap, e))
      .toList(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => $enumDecode(_$BlockCategoryEnumMap, e))
      .toList(),
  screens: (json['screens'] as List<dynamic>)
      .map((e) => $enumDecode(_$ScreensEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$BlockMetaToJson(BlockMeta instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'files': instance.files,
  'selfFiles': instance.selfFiles,
  'types': instance.types.map((e) => _$BlockTypeEnumMap[e]!).toList(),
  'categories': instance.categories
      .map((e) => _$BlockCategoryEnumMap[e]!)
      .toList(),
  'screens': instance.screens.map((e) => _$ScreensEnumMap[e]!).toList(),
};

const _$BlockTypeEnumMap = {
  BlockType.formBlock: 'formBlock',
  BlockType.cardBlock: 'cardBlock',
  BlockType.listBlock: 'listBlock',
  BlockType.navBlock: 'navBlock',
  BlockType.mediaBlock: 'mediaBlock',
  BlockType.statsBlock: 'statsBlock',
  BlockType.headerBlock: 'headerBlock',
  BlockType.footerBlock: 'footerBlock',
  BlockType.gridBlock: 'gridBlock',
  BlockType.tableBlock: 'tableBlock',
};

const _$BlockCategoryEnumMap = {
  BlockCategory.blockCategoty: 'blockCategoty',
  BlockCategory.formBlock: 'formBlock',
  BlockCategory.cardBlock: 'cardBlock',
  BlockCategory.listBlock: 'listBlock',
  BlockCategory.navBlock: 'navBlock',
  BlockCategory.mediaBlock: 'mediaBlock',
  BlockCategory.statsBlock: 'statsBlock',
  BlockCategory.headerBlock: 'headerBlock',
  BlockCategory.footerBlock: 'footerBlock',
  BlockCategory.gridBlock: 'gridBlock',
  BlockCategory.tableBlock: 'tableBlock',
};

ComponentMeta _$ComponentMetaFromJson(Map<String, dynamic> json) =>
    ComponentMeta(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => FileMeta.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      types: (json['types'] as List<dynamic>)
          .map((e) => $enumDecode(_$ComponentTypeEnumMap, e))
          .toList(),
      selfFiles:
          (json['selfFiles'] as List<dynamic>?)
              ?.map((e) => FileMeta.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>)
          .map((e) => $enumDecode(_$ComponentCategoryEnumMap, e))
          .toList(),
      screens: (json['screens'] as List<dynamic>)
          .map((e) => $enumDecode(_$ScreensEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$ComponentMetaToJson(ComponentMeta instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'files': instance.files,
      'selfFiles': instance.selfFiles,
      'types': instance.types.map((e) => _$ComponentTypeEnumMap[e]!).toList(),
      'categories': instance.categories
          .map((e) => _$ComponentCategoryEnumMap[e]!)
          .toList(),
      'screens': instance.screens.map((e) => _$ScreensEnumMap[e]!).toList(),
    };

const _$ComponentTypeEnumMap = {
  ComponentType.blockCategoty: 'blockCategoty',
  ComponentType.button: 'button',
  ComponentType.appBar: 'appBar',
  ComponentType.textField: 'textField',
  ComponentType.card: 'card',
  ComponentType.progressBar: 'progressBar',
  ComponentType.tabBar: 'tabBar',
  ComponentType.bottomNavigation: 'bottomNavigation',
  ComponentType.progressIndicator: 'progressIndicator',
  ComponentType.sidebar: 'sidebar',
  ComponentType.charts: 'charts',
};

const _$ComponentCategoryEnumMap = {
  ComponentCategory.componentCategoty: 'componentCategoty',
  ComponentCategory.formsInputs: 'formsInputs',
  ComponentCategory.navigation: 'navigation',
  ComponentCategory.feedback: 'feedback',
  ComponentCategory.overlays: 'overlays',
  ComponentCategory.dataDisplay: 'dataDisplay',
  ComponentCategory.layoutStructure: 'layoutStructure',
  ComponentCategory.typography: 'typography',
  ComponentCategory.media: 'media',
};
