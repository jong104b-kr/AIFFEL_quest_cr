import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

// /home/ubuntu/app/byun_s_application/lib/presentation/main_screen/widgets/recommended_problem_card_widget.dart




class RecommendedProblemCardWidget extends StatelessWidget {
  final String title;
  final String difficulty;
  final List<String> tags;
  final VoidCallback onTap;

  const RecommendedProblemCardWidget({
    Key? key,
    required this.title,
    required this.difficulty,
    required this.tags,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200.h,
        padding: EdgeInsets.all(16.h),
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
                    color: difficulty == '상'
                        ? Colors.red.withAlpha(26)
                        : difficulty == '중'
                            ? Colors.orange.withAlpha(26)
                            : Colors.green.withAlpha(26),
                    borderRadius: BorderRadius.circular(4.h),
                  ),
                  child: Text(
                    '난이도: $difficulty',
                    style: TextStyleHelper.instance.body12SemiBold.copyWith(
                      color: difficulty == '상'
                          ? Colors.red
                          : difficulty == '중'
                              ? Colors.orange
                              : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyleHelper.instance.title16Medium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 8.h,
              runSpacing: 8.h,
              children: tags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: appTheme.gray100,
                    borderRadius: BorderRadius.circular(4.h),
                  ),
                  child: Text(
                    tag,
                    style: TextStyleHelper.instance.body12SemiBold.copyWith(
                      color: appTheme.gray900,
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
                decoration: BoxDecoration(
                  color: appTheme.black,
                  borderRadius: BorderRadius.circular(6.h),
                ),
                child: Text(
                  '풀어보기',
                  style: TextStyleHelper.instance.body12SemiBold.copyWith(
                    color: appTheme.whiteCustom,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}