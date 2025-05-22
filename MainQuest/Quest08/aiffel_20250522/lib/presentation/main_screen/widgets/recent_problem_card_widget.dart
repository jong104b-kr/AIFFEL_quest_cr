import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

// /home/ubuntu/app/byun_s_application/lib/presentation/main_screen/widgets/recent_problem_card_widget.dart




class RecentProblemCardWidget extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final int score;
  final VoidCallback onTap;

  const RecentProblemCardWidget({
    Key? key,
    required this.title,
    required this.category,
    required this.date,
    required this.score,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180.h,
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          border: Border.all(color: appTheme.gray200),
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: appTheme.gray100,
                    borderRadius: BorderRadius.circular(4.h),
                  ),
                  child: Text(
                    category,
                    style: TextStyleHelper.instance.body12SemiBold.copyWith(
                      color: appTheme.gray900,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: TextStyleHelper.instance.body12SemiBold.copyWith(
                    color: appTheme.gray500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyleHelper.instance.body14Medium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '정답률',
                  style: TextStyleHelper.instance.body12SemiBold.copyWith(
                    color: appTheme.gray500,
                  ),
                ),
                Text(
                  '$score%',
                  style: TextStyleHelper.instance.body14Medium.copyWith(
                    color: score >= 90
                        ? Colors.green
                        : score >= 70
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            LinearProgressIndicator(
              value: score / 100,
              backgroundColor: appTheme.gray200,
              valueColor: AlwaysStoppedAnimation<Color>(
                score >= 90
                    ? Colors.green
                    : score >= 70
                        ? Colors.orange
                        : Colors.red,
              ),
              borderRadius: BorderRadius.circular(2.h),
            ),
          ],
        ),
      ),
    );
  }
}