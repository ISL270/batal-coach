part of '../clients_screen.dart';

class _ClientsListView extends StatelessWidget {
  const _ClientsListView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        decoration: BoxDecoration(color: context.colorsX.secondaryBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SearchAndFilterWidget(),
            const Gap(10),
            Text(
              '${context.l10n.allClients} (3)',
              style: context.textThemeX.small.bold
                  .copyWith(color: context.colorsX.onBackgroundTint),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _ClientWidget(
                  client: Client(
                    email: 'clientEmail@mail.com',
                    name: 'slam Ashraf',
                    phoneNumber: '+201146012354',
                    id: '20215',
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Divider(
                    height: 1,
                    thickness: 0.5,
                    color: context.colorsX.onBackgroundTint,
                  ),
                );
              },
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientWidget extends StatelessWidget {
  const _ClientWidget({required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: context.colorsX.secondary,
          radius: 28.sp,
          child: Text(
            client.name.initials,
            style: context.textThemeX.large.copyWith(
              color: context.colorsX.secondaryBackground,
              fontSize: 22.sp,
            ),
          ),
        ),
        title: Text(client.name, style: context.textThemeX.large.bold),
        subtitle: Text(client.phoneNumber,
            style: context.textThemeX.small
                .copyWith(color: context.colorsX.onBackgroundTint)),
      ),
    );
  }
}

class _SearchAndFilterWidget extends StatelessWidget {
  const _SearchAndFilterWidget();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterBloc(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 0.36.sh,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: '${context.l10n.searchClients}...',
                prefixIcon:
                    Icon(Icons.search, color: context.colorsX.onBackgroundTint),
              ),
            ),
          ),
          Gap(20.w),
          BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              final isFilterSelected = state.selectedFilters.isNotEmpty;
              return InkWell(
                onTap: () => _showFilterBottomSheet(context),
                child: Icon(
                  Icons.filter_list,
                  color: isFilterSelected
                      ? context.colorsX.primary
                      : context.colorsX.onBackgroundTint,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) =>
      showModalBottomSheet<void>(
        backgroundColor: context.colorsX.secondaryBackground,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
        ),
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<FilterBloc>(context),
            child: const _FilterBottomSheet(),
          );
        },
      );
}

class _FilterBottomSheet extends StatelessWidget {
  const _FilterBottomSheet();

  @override
  Widget build(BuildContext context) {
    final filters = [
      context.l10n.connected,
      context.l10n.pending,
      context.l10n.archived
    ];
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<FilterBloc>(context).add(ClearFilters());
                    context.pop();
                  },
                  child: Text(
                    context.l10n.clear,
                    style: context.textThemeX.medium
                        .copyWith(color: context.colorsX.secondary),
                  )),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<FilterBloc>(context).add(SearchFilters());
                    context.pop();
                  },
                  child: Text(
                    context.l10n.search,
                    style: context.textThemeX.medium,
                  )),
            ],
          ),
          Text(context.l10n.selectFilter,
              style: context.textThemeX.small.copyWith(
                color: context.colorsX.onBackgroundTint,
              )),
          SizedBox(height: 16.h),
          SizedBox(
            height: 170.h,
            child: ListView.builder(
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    final selectedFilter = state.selectedFilters.isEmpty
                        ? null
                        : state.selectedFilters.first;

                    return RadioListTile<String>(
                      activeColor: context.colorsX.primary,
                      title: Text(filter),
                      value: filter,
                      groupValue: selectedFilter,
                      onChanged: (value) {
                        if (value != null) {
                          BlocProvider.of<FilterBloc>(context)
                              .add(ToggleFilter(filter));
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
