part of '../client_tasks_screen.dart';

class _WeekSelector extends StatefulWidget {
  const _WeekSelector();

  @override
  State<_WeekSelector> createState() => _WeekSelectorState();
}

class _WeekSelectorState extends State<_WeekSelector> {
  DateTime _currentDate = DateTime.now();

  void _previousWeek() {
    setState(() {
      _currentDate = _currentDate.subtract(const Duration(days: 7));
    });
  }

  // Move to the next week
  void _nextWeek() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left arrow
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: context.colorsX.primary,
          ),
          onPressed: _previousWeek,
        ),
        // Content
        Column(
          children: [
            // 'This Week' dropdown
            Text(
              'THIS WEEK',
              style: context.textThemeX.medium.bold.copyWith(
                color: context.colorsX.primary,
              ),
            ),
            const Gap(4),
            Text(
              DateTime.now().getWeekRange(_currentDate),
              style: context.textThemeX.medium.bold,
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.chevron_right,
            color: context.colorsX.primary,
          ),
          onPressed: _nextWeek,
        ),
      ],
    );
  }
}
