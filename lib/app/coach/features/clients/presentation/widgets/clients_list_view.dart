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
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                '${context.l10n.allClients.toUpperCase()} (3)',
                style: context.textThemeX.small.bold.copyWith(
                  color: context.colorsX.onBackgroundTint.withValues(alpha: 0.5),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _ClientWidget(
                  client: Client(
                    email: 'clientEmail@mail.com',
                    name: Name.fromString('Eslam Ashraf'),
                    phoneNumber: '+201146012354',
                    id: '20215',
                    lastActiveAt: DateTime.now(),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Divider(
                    height: 1,
                    thickness: 0.5,
                    color: context.colorsX.onBackgroundTint35.withValues(alpha: 0.1),
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
      onTap: () => context.pushNamed(ClientDetailsScreen.name),
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
        title: Text(client.name.value, style: context.textThemeX.large.bold),
        subtitle: Text(client.clientLastSeen(context),
            style: context.textThemeX.small.copyWith(color: context.colorsX.onBackgroundTint)),
      ),
    );
  }
}

class _SearchAndFilterWidget extends StatelessWidget {
  const _SearchAndFilterWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 0.34.sh,
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: context.colorsX.onBackgroundTint35.withValues(alpha: 0.03),
              labelText: '${context.l10n.searchClients}...',
              prefixIcon: Icon(
                Icons.search,
                color: context.colorsX.onBackgroundTint35,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none, // Removes the visible border
                borderRadius: BorderRadius.circular(8.sp), // Add border radius
              ),
            ),
          ),
        ),
        Gap(20.w),
        InkWell(
          onTap: () => _showFilterBottomSheet(context),
          child: Icon(
            Icons.tune,
            color: context.colorsX.primary,
          ),
        )
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) => showModalBottomSheet<void>(
        backgroundColor: context.colorsX.secondaryBackground,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
        ),
        builder: (_) {
          return const _FilterBottomSheet();
        },
      );
}

class _FilterBottomSheet extends StatelessWidget {
  const _FilterBottomSheet();

  @override
  Widget build(BuildContext context) {
    final filters = [context.l10n.connected, context.l10n.pending, context.l10n.archived];
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
                    context.pop();
                  },
                  child: Text(
                    context.l10n.clear,
                    style: context.textThemeX.medium.copyWith(color: context.colorsX.secondary),
                  )),
              TextButton(
                  onPressed: () {
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

                return RadioListTile<String>(
                  activeColor: context.colorsX.primary,
                  title: Text(filter),
                  value: filter,
                  groupValue: '',
                  onChanged: (value) {
                    if (value != null) {}
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
