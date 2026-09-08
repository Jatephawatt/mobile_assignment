import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_assignment_coin/models/coin_response_model.dart';

part 'coin_detail_response.g.dart';

@JsonSerializable()
class CoinDetailResponseModel {
  String? status;
  CoinDetailInformationModel? data;

  CoinDetailResponseModel({this.status, this.data});

  factory CoinDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDetailResponseModelToJson(this);
}

@JsonSerializable()
class CoinDetailInformationModel {
  CoinDetailDataModel? coin;

  CoinDetailInformationModel({this.coin});

  factory CoinDetailInformationModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDetailInformationModelToJson(this);
}

@JsonSerializable()
class CoinDetailDataModel extends CoinsModel {
  String? description;
  String? websiteUrl;
  List<LinksModel>? links;
  SupplyModel? supply;
  int? numberOfMarkets;
  int? numberOfExchanges;
  String? fullyDilutedMarketCap;
  int? priceAt;
  bool? hasContent;
  dynamic notices;
  List<String>? tags;

  CoinDetailDataModel({
    super.uuid,
    super.symbol,
    super.name,
    super.color,
    super.iconUrl,
    super.s24hVolume,
    super.marketCap,
    super.price,
    super.btcPrice,
    super.change,
    super.rank,
    super.sparkline,
    super.allTimeHigh,
    super.coinrankingUrl,
    super.tier,
    super.lowVolume,
    super.listedAt,
    super.contractAddresses,
    super.isWrappedTrustless,
    super.wrappedTo,
    super.coinGeckoId,
    super.coinMarketCapId,
    this.description,
    this.websiteUrl,
    this.links,
    this.supply,
    this.numberOfMarkets,
    this.numberOfExchanges,
    this.fullyDilutedMarketCap,
    this.priceAt,
    this.hasContent,
    this.notices,
    this.tags,
  });

  factory CoinDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailDataModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CoinDetailDataModelToJson(this);
}

@JsonSerializable()
class LinksModel {
  String? name;
  String? url;
  String? type;

  LinksModel({this.name, this.url, this.type});

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinksModelToJson(this);
}

@JsonSerializable()
class SupplyModel {
  bool? confirmed;
  int? supplyAt;
  String? max;
  String? total;
  String? circulating;

  SupplyModel({
    this.confirmed,
    this.supplyAt,
    this.max,
    this.total,
    this.circulating,
  });

  factory SupplyModel.fromJson(Map<String, dynamic> json) =>
      _$SupplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyModelToJson(this);
}
