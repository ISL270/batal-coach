part of '../add_client_screen.dart';

class _ClientCategoryWidget extends StatefulWidget {
  const _ClientCategoryWidget();

  @override
  State<_ClientCategoryWidget> createState() => _ClientCategoryWidgetState();
}

class _ClientCategoryWidgetState extends State<_ClientCategoryWidget> {
  final List<bool> _isSelected = [true, false, false];
  bool _sendEmailInvitation = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.clientCategory, style: context.textThemeX.large.bold),
        SizedBox(height: 20.h),
        ToggleButtons(
          borderColor: context.colorsX.onBackground,
          borderWidth: 0.2,
          isSelected: _isSelected,
          onPressed: (index) {
            setState(() {
              for (var i = 0; i < _isSelected.length; i++) {
                _isSelected[i] = i == index;
              }
            });
          },
          color: context.colorsX.onBackgroundTint,
          selectedColor: Colors.white,
          fillColor: context.colorsX.primary,
          borderRadius: BorderRadius.circular(20.w),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(context.l10n.online),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(context.l10n.inPerson),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(context.l10n.hybrid),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.mailInvitation,
                    style: context.textThemeX.large.bold),
                Text(
                  context.l10n.mailInvitationDes,
                  style: context.textThemeX.medium.copyWith(
                    color: context.colorsX.onBackgroundTint,
                  ),
                ),
              ],
            ),
            Switch(
              value: _sendEmailInvitation,
              onChanged: (value) {
                setState(() {
                  _sendEmailInvitation = value;
                });
              },
              activeColor: context.colorsX.primary,
            ),
          ],
        ),
      ],
    );
  }
}
