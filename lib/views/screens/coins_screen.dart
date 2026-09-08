import 'package:flutter/material.dart';
import 'package:mobile_assignment_coin/core/constants/app_colors.dart';
import 'package:mobile_assignment_coin/viewModels/coins_view_model.dart';
import 'package:mobile_assignment_coin/views/widgets/bottom_loading_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/bottom_pagination_error_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/coin_list_item.dart';
import 'package:mobile_assignment_coin/views/widgets/coin_search_bar.dart';
import 'package:mobile_assignment_coin/views/widgets/empty_search_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/error_state_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/invite_banner_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/loading_state_widget.dart';
import 'package:mobile_assignment_coin/views/widgets/top_3_coins_widget.dart';
import 'package:provider/provider.dart';

class CoinsScreen extends StatelessWidget {
  const CoinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoinsViewModel>(
      create: (context) => CoinsViewModel()..initViewModel(context: context),
      child: const _CoinsScreenContent(),
    );
  }
}

class _CoinsScreenContent extends StatefulWidget {
  const _CoinsScreenContent();

  @override
  State<_CoinsScreenContent> createState() => _CoinsScreenContentState();
}

class _CoinsScreenContentState extends State<_CoinsScreenContent> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<CoinsViewModel>().loadMoreCoins(context: context);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CoinsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: CoinSearchBar(
                    controller: _searchController,
                    onChanged: (val) => viewModel.onSearchChanged(context, val),
                    onClear: () => viewModel.clearSearch(context),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.textSecondary,
                    notificationPredicate: viewModel.isSearching
                        ? (_) => false
                        : (_) => true,
                    onRefresh: viewModel.isSearching
                        ? () async {}
                        : () async {
                            await viewModel.loadCoins(
                              context: context,
                              isRefresh: true,
                            );
                          },
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        if (!viewModel.isSearching &&
                            viewModel.topCoins.isNotEmpty)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Top3CoinsWidget(
                                topCoins: viewModel.topCoins,
                                onCoinTapped: (coin) => viewModel.onCoinTapped(
                                  context: context,
                                  coin: coin,
                                ),
                              ),
                            ),
                          ),
                        if (viewModel.isLoading && viewModel.coins.isEmpty)
                          const LoadingStateWidget()
                        else if (viewModel.hasError && viewModel.coins.isEmpty)
                          ErrorStateWidget(
                            errorMessage: viewModel.errorMessage,
                            onRetry: () => viewModel.retry(context: context),
                          )
                        else if (viewModel.coins.isEmpty &&
                            viewModel.isSearching)
                          EmptySearchWidget(
                            keyword: viewModel.searchKeyword,
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final coin = viewModel.coins[index];
                                final coinItem = CoinListItem(
                                  coin: coin,
                                  onTap: () => viewModel.onCoinTapped(
                                    context: context,
                                    coin: coin,
                                  ),
                                );

                                if (viewModel.isInviteBannerPosition(index)) {
                                  return Column(
                                    children: [
                                      coinItem,
                                      InviteBannerWidget(
                                        onTap: () =>
                                            viewModel.onInviteBannerTapped(),
                                      ),
                                    ],
                                  );
                                }
                                return coinItem;
                              },
                              childCount: viewModel.coins.length,
                            ),
                          ),
                        if (viewModel.isFetchingNextPage)
                          const BottomLoadingWidget(),
                        if (viewModel.paginationError)
                          BottomPaginationErrorWidget(
                            onRetry: () =>
                                viewModel.retryPagination(context: context),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
