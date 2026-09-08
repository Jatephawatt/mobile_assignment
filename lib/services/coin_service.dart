import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/api_constants.dart';
import 'package:mobile_assignment_coin/models/coin_detail_response.dart';
import 'package:mobile_assignment_coin/models/coin_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'coin_service.g.dart';

@RestApi()
abstract class CoinService {
  factory CoinService(Dio dio, {String? baseUrl}) = _CoinService;

  static CoinService execute({required BuildContext context}) {
    Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['x-rapidapi-key'] =
              '5b47ee540cmsh41ef44190028077p1557a1jsna27cd11b38a7';
          options.headers['x-rapidapi-host'] = 'coinranking1.p.rapidapi.com';
          return handler.next(options);
        },
      ),
    );
    return CoinService(dio);
  }

  @GET('/coins')
  Future<CoinResponseModel> getCoins({
    @Query('offset') int offset = 0,
    @Query('limit') int limit = 10,
    @Query('search') String? search,
  });

  @GET('/coin/{uuid}')
  Future<CoinDetailResponseModel> getCoinsDetail({
    @Path('uuid') required String uuid,
  });
}
