// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinDetailResponseModel _$CoinDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => CoinDetailResponseModel(
  status: json['status'] as String?,
  data: json['data'] == null
      ? null
      : CoinDetailInformationModel.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CoinDetailResponseModelToJson(
  CoinDetailResponseModel instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

CoinDetailInformationModel _$CoinDetailInformationModelFromJson(
  Map<String, dynamic> json,
) => CoinDetailInformationModel(
  coin: json['coin'] == null
      ? null
      : CoinDetailDataModel.fromJson(json['coin'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CoinDetailInformationModelToJson(
  CoinDetailInformationModel instance,
) => <String, dynamic>{'coin': instance.coin};

CoinDetailDataModel _$CoinDetailDataModelFromJson(Map<String, dynamic> json) =>
    CoinDetailDataModel(
      uuid: json['uuid'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      iconUrl: json['iconUrl'] as String?,
      s24hVolume: json['s24hVolume'] as String?,
      marketCap: json['marketCap'] as String?,
      price: json['price'] as String?,
      btcPrice: json['btcPrice'] as String?,
      change: json['change'] as String?,
      rank: (json['rank'] as num?)?.toInt(),
      sparkline: (json['sparkline'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allTimeHigh: json['allTimeHigh'] == null
          ? null
          : AllTimeHighModel.fromJson(
              json['allTimeHigh'] as Map<String, dynamic>,
            ),
      coinrankingUrl: json['coinrankingUrl'] as String?,
      tier: (json['tier'] as num?)?.toInt(),
      lowVolume: json['lowVolume'] as bool?,
      listedAt: (json['listedAt'] as num?)?.toInt(),
      contractAddresses: (json['contractAddresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isWrappedTrustless: json['isWrappedTrustless'] as bool?,
      wrappedTo: json['wrappedTo'],
      coinGeckoId: json['coinGeckoId'] as String?,
      coinMarketCapId: json['coinMarketCapId'] as String?,
      description: json['description'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => LinksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      supply: json['supply'] == null
          ? null
          : SupplyModel.fromJson(json['supply'] as Map<String, dynamic>),
      numberOfMarkets: (json['numberOfMarkets'] as num?)?.toInt(),
      numberOfExchanges: (json['numberOfExchanges'] as num?)?.toInt(),
      fullyDilutedMarketCap: json['fullyDilutedMarketCap'] as String?,
      priceAt: (json['priceAt'] as num?)?.toInt(),
      hasContent: json['hasContent'] as bool?,
      notices: json['notices'],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CoinDetailDataModelToJson(
  CoinDetailDataModel instance,
) => <String, dynamic>{
  'uuid': instance.uuid,
  'symbol': instance.symbol,
  'name': instance.name,
  'color': instance.color,
  'iconUrl': instance.iconUrl,
  'marketCap': instance.marketCap,
  'price': instance.price,
  'listedAt': instance.listedAt,
  'tier': instance.tier,
  'change': instance.change,
  'rank': instance.rank,
  'sparkline': instance.sparkline,
  'allTimeHigh': instance.allTimeHigh,
  'lowVolume': instance.lowVolume,
  'coinrankingUrl': instance.coinrankingUrl,
  's24hVolume': instance.s24hVolume,
  'btcPrice': instance.btcPrice,
  'contractAddresses': instance.contractAddresses,
  'isWrappedTrustless': instance.isWrappedTrustless,
  'wrappedTo': instance.wrappedTo,
  'coinGeckoId': instance.coinGeckoId,
  'coinMarketCapId': instance.coinMarketCapId,
  'description': instance.description,
  'websiteUrl': instance.websiteUrl,
  'links': instance.links,
  'supply': instance.supply,
  'numberOfMarkets': instance.numberOfMarkets,
  'numberOfExchanges': instance.numberOfExchanges,
  'fullyDilutedMarketCap': instance.fullyDilutedMarketCap,
  'priceAt': instance.priceAt,
  'hasContent': instance.hasContent,
  'notices': instance.notices,
  'tags': instance.tags,
};

LinksModel _$LinksModelFromJson(Map<String, dynamic> json) => LinksModel(
  name: json['name'] as String?,
  url: json['url'] as String?,
  type: json['type'] as String?,
);

Map<String, dynamic> _$LinksModelToJson(LinksModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'type': instance.type,
    };

SupplyModel _$SupplyModelFromJson(Map<String, dynamic> json) => SupplyModel(
  confirmed: json['confirmed'] as bool?,
  supplyAt: (json['supplyAt'] as num?)?.toInt(),
  max: json['max'] as String?,
  total: json['total'] as String?,
  circulating: json['circulating'] as String?,
);

Map<String, dynamic> _$SupplyModelToJson(SupplyModel instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'supplyAt': instance.supplyAt,
      'max': instance.max,
      'total': instance.total,
      'circulating': instance.circulating,
    };
