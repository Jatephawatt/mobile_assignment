// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinResponseModel _$CoinResponseModelFromJson(
  Map<String, dynamic> json,
) => CoinResponseModel(
  status: json['status'] as String?,
  data: json['data'] == null
      ? null
      : CoinDataInformationModel.fromJson(json['data'] as Map<String, dynamic>),
  pagination: json['pagination'] == null
      ? null
      : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CoinResponseModelToJson(CoinResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'pagination': instance.pagination,
    };

CoinDataInformationModel _$CoinDataInformationModelFromJson(
  Map<String, dynamic> json,
) => CoinDataInformationModel(
  stats: json['stats'] == null
      ? null
      : CoinStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
  coins: (json['coins'] as List<dynamic>?)
      ?.map((e) => CoinsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CoinDataInformationModelToJson(
  CoinDataInformationModel instance,
) => <String, dynamic>{'stats': instance.stats, 'coins': instance.coins};

CoinStatsModel _$CoinStatsModelFromJson(Map<String, dynamic> json) =>
    CoinStatsModel(
      total: (json['total'] as num?)?.toInt(),
      totalCoins: (json['totalCoins'] as num?)?.toInt(),
      totalMarkets: (json['totalMarkets'] as num?)?.toInt(),
      totalExchanges: (json['totalExchanges'] as num?)?.toInt(),
      totalMarketCap: json['totalMarketCap'] as String?,
      total24hVolume: json['total24hVolume'] as String?,
    );

Map<String, dynamic> _$CoinStatsModelToJson(CoinStatsModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalCoins': instance.totalCoins,
      'totalMarkets': instance.totalMarkets,
      'totalExchanges': instance.totalExchanges,
      'totalMarketCap': instance.totalMarketCap,
      'total24hVolume': instance.total24hVolume,
    };

CoinsModel _$CoinsModelFromJson(Map<String, dynamic> json) => CoinsModel(
  uuid: json['uuid'] as String?,
  symbol: json['symbol'] as String?,
  name: json['name'] as String?,
  color: json['color'] as String?,
  iconUrl: json['iconUrl'] as String?,
  marketCap: json['marketCap'] as String?,
  price: json['price'] as String?,
  listedAt: (json['listedAt'] as num?)?.toInt(),
  tier: (json['tier'] as num?)?.toInt(),
  change: json['change'] as String?,
  rank: (json['rank'] as num?)?.toInt(),
  sparkline: (json['sparkline'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  allTimeHigh: json['allTimeHigh'] == null
      ? null
      : AllTimeHighModel.fromJson(json['allTimeHigh'] as Map<String, dynamic>),
  lowVolume: json['lowVolume'] as bool?,
  coinrankingUrl: json['coinrankingUrl'] as String?,
  s24hVolume: json['s24hVolume'] as String?,
  btcPrice: json['btcPrice'] as String?,
  contractAddresses: (json['contractAddresses'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  isWrappedTrustless: json['isWrappedTrustless'] as bool?,
  wrappedTo: json['wrappedTo'],
  coinGeckoId: json['coinGeckoId'] as String?,
  coinMarketCapId: json['coinMarketCapId'] as String?,
);

Map<String, dynamic> _$CoinsModelToJson(CoinsModel instance) =>
    <String, dynamic>{
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
    };

AllTimeHighModel _$AllTimeHighModelFromJson(Map<String, dynamic> json) =>
    AllTimeHighModel(
      price: json['price'] as String?,
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AllTimeHighModelToJson(AllTimeHighModel instance) =>
    <String, dynamic>{'price': instance.price, 'timestamp': instance.timestamp};

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      limit: (json['limit'] as num?)?.toInt(),
      hasNextPage: json['hasNextPage'] as bool?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      nextCursor: json['nextCursor'] as String?,
      previousCursor: json['previousCursor'],
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'nextCursor': instance.nextCursor,
      'previousCursor': instance.previousCursor,
    };
