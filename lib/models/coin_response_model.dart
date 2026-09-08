import 'package:json_annotation/json_annotation.dart';
part 'coin_response_model.g.dart';

@JsonSerializable()
class CoinResponseModel {
  String? status;
  CoinDataInformationModel? data;
  PaginationModel? pagination;

  CoinResponseModel({this.status, this.data, this.pagination});

  factory CoinResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CoinResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinResponseModelToJson(this);
}

@JsonSerializable()
class CoinDataInformationModel {
  CoinStatsModel? stats;
  List<CoinsModel>? coins;

  CoinDataInformationModel({this.stats, this.coins});

  factory CoinDataInformationModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDataInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDataInformationModelToJson(this);
}

@JsonSerializable()
class CoinStatsModel {
  int? total;
  int? totalCoins;
  int? totalMarkets;
  int? totalExchanges;
  String? totalMarketCap;
  String? total24hVolume;

  CoinStatsModel({
    this.total,
    this.totalCoins,
    this.totalMarkets,
    this.totalExchanges,
    this.totalMarketCap,
    this.total24hVolume,
  });

  factory CoinStatsModel.fromJson(Map<String, dynamic> json) =>
      _$CoinStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinStatsModelToJson(this);
}

@JsonSerializable()
class CoinsModel {
  String? uuid;
  String? symbol;
  String? name;
  String? color;
  String? iconUrl;
  String? marketCap;
  String? price;
  int? listedAt;
  int? tier;
  String? change;
  int? rank;
  List<String>? sparkline;
  AllTimeHighModel? allTimeHigh;
  bool? lowVolume;
  String? coinrankingUrl;
  String? s24hVolume;
  String? btcPrice;
  List<String>? contractAddresses;
  bool? isWrappedTrustless;
  dynamic wrappedTo;
  String? coinGeckoId;
  String? coinMarketCapId;

  CoinsModel({
    this.uuid,
    this.symbol,
    this.name,
    this.color,
    this.iconUrl,
    this.marketCap,
    this.price,
    this.listedAt,
    this.tier,
    this.change,
    this.rank,
    this.sparkline,
    this.allTimeHigh,
    this.lowVolume,
    this.coinrankingUrl,
    this.s24hVolume,
    this.btcPrice,
    this.contractAddresses,
    this.isWrappedTrustless,
    this.wrappedTo,
    this.coinGeckoId,
    this.coinMarketCapId,
  });

  factory CoinsModel.fromJson(Map<String, dynamic> json) =>
      _$CoinsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinsModelToJson(this);
}

@JsonSerializable()
class AllTimeHighModel {
  String? price;
  int? timestamp;

  AllTimeHighModel({this.price, this.timestamp});

  factory AllTimeHighModel.fromJson(Map<String, dynamic> json) =>
      _$AllTimeHighModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllTimeHighModelToJson(this);
}

@JsonSerializable()
class PaginationModel {
  int? limit;
  bool? hasNextPage;
  bool? hasPreviousPage;
  String? nextCursor;
  dynamic previousCursor;

  PaginationModel({
    this.limit,
    this.hasNextPage,
    this.hasPreviousPage,
    this.nextCursor,
    this.previousCursor,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}
