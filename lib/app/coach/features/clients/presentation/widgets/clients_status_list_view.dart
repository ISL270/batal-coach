part of '../clients_screen.dart';

class _ClientsStatusListView extends StatelessWidget {
  const _ClientsStatusListView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ClientStatus.values.map((status) {
          return _ClientsStatusCard(
            statusInfo: status,
            title: status.title(context),
          );
        }).toList(),
      ),
    );
  }
}

class _ClientsStatusCard extends StatelessWidget {
  const _ClientsStatusCard({required this.statusInfo, required this.title});

  final ClientStatus statusInfo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorsX.secondaryBackground,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        width: 130.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              statusInfo.emoji,
              style: context.textThemeX.heading.copyWith(fontSize: 26.sp),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  statusInfo.count,
                  style: context.textThemeX.heading.copyWith(fontSize: 32.sp),
                ),
                Text(
                  title,
                  style: context.textThemeX.medium.bold
                      .copyWith(color: context.colorsX.onBackgroundTint35),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
