import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/search_section_widget.dart';

class ProblemSearchScreen extends StatelessWidget {
  const ProblemSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteCustom,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchSectionWidget(
              title: '기출문제 형식으로 풀기',
              subtitle: 'Sep 12 – 15',
              detail1: '1 room',
              detail2: '2 guests',
              onEditPressed: () {
                // Handle edit action
              },
              onFilterPressed: () {
                // Handle filter action
              },
              onSortPressed: () {
                // Handle sort action
              },
            ),
            SearchSectionWidget(
              title: '문제은행식 문제 풀기',
              subtitle: 'Sep 12 – 15',
              detail1: '1 room',
              detail2: '2 guests',
              onEditPressed: () {
                // Handle edit action
              },
              onFilterPressed: () {
                // Handle filter action
              },
              onSortPressed: () {
                // Handle sort action
              },
            ),
            SizedBox(height: 83.h), // Space for bottom navigation bar
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: appTheme.whiteCustom,
      leadingWidth: 48.h,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: InkWell(
          onTap: () {
            // Handle menu click
          },
          child: CustomImageView(
            imagePath: ImageConstant.imgIconMenu,
            height: 24.h,
            width: 24.h,
          ),
        ),
      ),
      title: Text('문제선택', style: TextStyleHelper.instance.title20SemiBold),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.h),
          child: Container(
            height: 24.h,
            width: 24.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgProfileImage,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(12.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 83.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        boxShadow: [
          BoxShadow(
            color: appTheme.blackCustom.withAlpha(26),
            offset: Offset(0, -1),
            blurRadius: 10.h,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
              icon: ImageConstant.imgIconHome,
              label: '홈',
              onTap: () {
                // Navigate to home
              },
            ),
            _buildBottomNavItem(
              icon: ImageConstant.imgIconCalendar,
              label: '지난 문제',
              onTap: () {
                // Navigate to calendar
              },
            ),
            _buildBottomNavItem(
              icon: ImageConstant.imgIconWallet,
              label: '문제 고르기',
              onTap: () {
                // Navigate to wallet
              },
            ),
            _buildBottomNavItem(
              icon: ImageConstant.imgIconPerson,
              label: '내 페이지',
              onTap: () {
                // Navigate to profile
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(imagePath: icon, height: 24.h, width: 24.h),
          SizedBox(height: 8.h),
          Text(label, style: TextStyleHelper.instance.body12SemiBold),
        ],
      ),
    );
  }
}