import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/api_constants.dart';
import 'package:mobile_assignment_coin/models/coin_detail_response.dart';
import 'package:mobile_assignment_coin/models/coin_response_model.dart';
import 'package:mobile_assignment_coin/services/coin_service.dart';
import 'package:mobile_assignment_coin/views/widgets/coin_detail_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

enum ViewState { initial, loading, loaded, error }

class CoinsViewModel extends ChangeNotifier {
  CoinsViewModel({CoinService? coinService, BuildContext? context});

  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  List<CoinsModel> _topCoins = [];
  List<CoinsModel> _coins = [];
  List<CoinsModel> _originalTopCoins = [];
  List<CoinsModel> _originalCoins = [];
  List<CoinsModel> _allMasterCoins = [];
  List<CoinsModel> _allFilteredCoins = [];
  int _searchOffset = 0;
  int _originalOffset = 0;
  bool _originalHasMore = true;

  bool _isLoading = false;
  bool _hasMore = true;
  bool _hasError = false;
  bool _isFetchingNextPage = false;
  bool _paginationError = false;
  String? _errorMessage;
  String _searchKeyword = '';
  final CoinDetailDataModel? _selectedCoinDetail = null;
  int _searchToken = 0;
  Timer? _debounceTimer;

  List<CoinsModel> get topCoins => _topCoins;
  List<CoinsModel> get coins => _coins;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool get isFetchingNextPage => _isFetchingNextPage;
  bool get paginationError => _paginationError;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;
  int _currentOffset = 0;
  String get searchKeyword => _searchKeyword;
  bool get isSearching => _searchKeyword.trim().isNotEmpty;
  CoinDetailDataModel? get selectedCoinDetail => _selectedCoinDetail;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> initViewModel({required BuildContext context}) async {
    if (_coins.isEmpty && _topCoins.isEmpty) {
      await loadCoins(context: context);
    }
  }

  Future<void> loadCoins({
    required BuildContext context,
    bool? isRefresh,
  }) async {
    final currentToken = ++_searchToken;

    if (isRefresh == true) {
      _currentOffset = 0;
      _hasMore = true;
      _paginationError = false;
    } else {
      _state = ViewState.loading;
    }

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final response = await CoinService.execute(context: context)
          .getCoins(limit: 50, offset: 0);

      if (currentToken != _searchToken) return;

      final allCoins = response.data?.coins ?? [];
      _allMasterCoins = List.from(allCoins);

      if (allCoins.length > 3) {
        _topCoins = allCoins.take(3).toList();
        _coins = allCoins.skip(3).toList();
      } else {
        _topCoins = List.from(allCoins);
        _coins = [];
      }
      _currentOffset = allCoins.length;
      _hasMore = allCoins.length >= 50;

      // Cache the default list so clearing search restores it instantly
      _originalTopCoins = List.from(_topCoins);
      _originalCoins = List.from(_coins);
      _originalOffset = _currentOffset;
      _originalHasMore = _hasMore;

      _state = ViewState.loaded;
      _paginationError = false;
    } catch (e) {
      if (currentToken != _searchToken) return;
      if (_coins.isEmpty && _topCoins.isEmpty) {
        _state = ViewState.error;
      } else {
        _paginationError = true;
      }
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      if (currentToken == _searchToken) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> searchCoins({
    required BuildContext context,
    bool isRefresh = true,
  }) async {
    final query = _searchKeyword.trim();
    if (query.isEmpty) {
      clearSearch(context);
      return;
    }

    final currentToken = ++_searchToken;
    _isLoading = true;
    _hasError = false;
    _topCoins = [];
    notifyListeners();

    try {
      if (_allMasterCoins.length < 100) {
        final response = await CoinService.execute(context: context)
            .getCoins(limit: 100, offset: 0);

        if (currentToken != _searchToken) return;

        final fetched = response.data?.coins ?? [];
        for (final c in fetched) {
          final key = c.uuid ?? c.symbol ?? c.name ?? '';
          if (!_allMasterCoins.any(
            (m) => (m.uuid ?? m.symbol ?? m.name) == key,
          )) {
            _allMasterCoins.add(c);
          }
        }
      }

      final q = query.toLowerCase();
      _allFilteredCoins = _allMasterCoins.where((coin) {
        final name = (coin.name ?? '').toLowerCase();
        final symbol = (coin.symbol ?? '').toLowerCase();
        return name.contains(q) || symbol.contains(q);
      }).toList();

      _searchOffset = AppConstants.pageSize;
      _coins = _allFilteredCoins.take(_searchOffset).toList();
      _hasMore = _coins.length < _allFilteredCoins.length;
      _state = ViewState.loaded;
    } catch (e) {
      if (currentToken != _searchToken) return;
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      if (currentToken == _searchToken) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> loadMoreCoins({required BuildContext context}) async {
    if (_isLoading || _isFetchingNextPage || !_hasMore) return;
    _isFetchingNextPage = true;
    notifyListeners();

    try {
      if (isSearching) {
        _searchOffset += AppConstants.pageSize;
        _coins = _allFilteredCoins.take(_searchOffset).toList();
        _hasMore = _coins.length < _allFilteredCoins.length;
      } else {
        final response = await CoinService.execute(context: context)
            .getCoins(offset: _currentOffset, limit: AppConstants.pageSize);

        final newCoins = response.data?.coins ?? [];
        if (newCoins.isNotEmpty) {
          _coins.addAll(newCoins);
          _currentOffset += newCoins.length;
          _originalCoins.addAll(newCoins);
          _originalOffset = _currentOffset;

          for (final c in newCoins) {
            final key = c.uuid ?? c.symbol ?? c.name ?? '';
            if (!_allMasterCoins.any(
              (m) => (m.uuid ?? m.symbol ?? m.name) == key,
            )) {
              _allMasterCoins.add(c);
            }
          }
        }

        if (newCoins.length < AppConstants.pageSize) {
          _hasMore = false;
          _originalHasMore = false;
        }
      }
    } catch (e) {
      _paginationError = true;
    } finally {
      _isFetchingNextPage = false;
      notifyListeners();
    }
  }

  void onSearchChanged(BuildContext context, String value) {
    _searchKeyword = value;
    _debounceTimer?.cancel();

    final query = value.trim();
    if (query.isEmpty) {
      clearSearch(context);
    } else {
      _debounceTimer = Timer(const Duration(seconds: 1), () {
        searchCoins(context: context);
      });
    }
  }

  void clearSearch(BuildContext context) {
    _debounceTimer?.cancel();
    _searchKeyword = '';
    _searchToken++;
    _topCoins = List.from(_originalTopCoins);
    _coins = List.from(_originalCoins);
    _currentOffset = _originalOffset;
    _hasMore = _originalHasMore;
    _allFilteredCoins = [];
    _searchOffset = 0;
    _isLoading = false;
    _hasError = false;
    _paginationError = false;
    _state = ViewState.loaded;
    notifyListeners();
  }

  Future<void> retry({required BuildContext context}) async {
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    if (isSearching) {
      await searchCoins(context: context);
    } else {
      await loadCoins(context: context, isRefresh: true);
    }
  }

  Future<void> retryPagination({required BuildContext context}) async {
    _paginationError = false;
    notifyListeners();
    await loadMoreCoins(context: context);
  }

  Future<void> onCoinTapped({
    required BuildContext context,
    required CoinsModel coin,
  }) async {
    CoinDetailBottomSheet.show(context, coin);
  }

  Future<void> onInviteBannerTapped() async {
    await SharePlus.instance.share(
      ShareParams(uri: Uri.parse(AppConstants.shareUrl)),
    );
  }

  bool isInviteBannerPosition(int index) {
    final position = index + 1;
    if (position < 5 || position % 5 != 0) return false;
    final quotient = position ~/ 5;
    return (quotient & (quotient - 1)) == 0;
  }
}
