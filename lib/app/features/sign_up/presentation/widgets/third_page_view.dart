part of '../sign_up_screen.dart';

class _ThirdPageView extends StatefulWidget {
  const _ThirdPageView();

  @override
  State<_ThirdPageView> createState() => ThirdPageView();
}

class ThirdPageView extends State<_ThirdPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SingleChildScrollView(
      key: PageStorageKey('third_page'),
      child: Padding(
        padding: EdgeInsets.only(top: 80, right: 20, left: 20),
        child: Column(
          children: [
            _CoachEmailField(),
            Gap(25),
            _PhoneNumberField(),
            Gap(180),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}
