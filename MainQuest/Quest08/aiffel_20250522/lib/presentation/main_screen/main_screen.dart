import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import './widgets/recent_problem_card_widget.dart';
import './widgets/recommended_problem_card_widget.dart';

// /home/ubuntu/app/byun_s_application/lib/presentation/main_screen/main_screen.dart










class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteCustom,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                _buildWelcomeSection(),
                SizedBox(height: 24.h),
                _buildQuickActionsSection(),
                SizedBox(height: 32.h),
                _buildRecentProblemsSection(),
                SizedBox(height: 32.h),
                _buildRecommendedProblemsSection(),
                SizedBox(height: 32.h),
                _buildPopularProblemsSection(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
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
      title: Text('홈', style: TextStyleHelper.instance.title20SemiBold),
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

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '안녕하세요, 학생님!',
          style: TextStyleHelper.instance.title20SemiBold,
        ),
        SizedBox(height: 8.h),
        Text(
          '오늘의 학습을 시작해볼까요?',
          style: TextStyleHelper.instance.body14.copyWith(
            color: appTheme.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '빠른 학습',
            style: TextStyleHelper.instance.title16Medium,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickActionItem(
                icon: ImageConstant.imgIconSearch,
                title: '문제 찾기',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchScreen);
                },
              ),
              _buildQuickActionItem(
                icon: ImageConstant.imgIconCalendar,
                title: '지난 문제',
                onTap: () {
                  // Navigate to past problems
                },
              ),
              _buildQuickActionItem(
                icon: ImageConstant.imgIconWallet,
                title: '문제 고르기',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.problemSearchScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              color: appTheme.whiteCustom,
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: CustomImageView(
              imagePath: icon,
              height: 24.h,
              width: 24.h,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyleHelper.instance.body12SemiBold,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentProblemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '최근 푼 문제',
              style: TextStyleHelper.instance.title16Medium,
            ),
            CustomButton(
              text: '더보기',
              imagePath: ImageConstant.imgIconChevron,
              imagePosition: CustomImagePosition.right,
              imageSize: Size(18.h, 18.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
              onTap: () {
                // View all recent problems
              },
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => SizedBox(width: 12.h),
            itemBuilder: (context, index) {
              // Sample data for recent problems
              final problem = {
                'title': index == 0
                    ? '2023년 6월 모의고사 수학 문제'
                    : index == 1
                        ? '삼각함수 응용 문제 세트'
                        : '기하와 벡터 기본 개념',
                'category': index == 0 ? '모의고사' : index == 1 ? '삼각함수' : '기하',
                'date': '${index + 1}일 전',
                'score': index == 0 ? 85 : index == 1 ? 92 : 78,
              };
              
              return RecentProblemCardWidget(
                title: problem['title'] as String,
                category: problem['category'] as String,
                date: problem['date'] as String,
                score: problem['score'] as int,
                onTap: () {
                  // View problem details
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedProblemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '추천 문제',
              style: TextStyleHelper.instance.title16Medium,
            ),
            CustomButton(
              text: '더보기',
              imagePath: ImageConstant.imgIconChevron,
              imagePosition: CustomImagePosition.right,
              imageSize: Size(18.h, 18.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
              onTap: () {
                // View all recommended problems
              },
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => SizedBox(width: 12.h),
            itemBuilder: (context, index) {
              // Sample data for recommended problems
              final problem = {
                'title': index == 0
                    ? '2023년 수능 대비 수학 문제'
                    : index == 1
                        ? '미적분 핵심 개념 문제'
                        : '확률과 통계 기출 모음',
                'difficulty': index == 0 ? '중' : index == 1 ? '상' : '하',
                'tags': index == 0
                    ? ['수능', '수학']
                    : index == 1
                        ? ['미적분', '고급']
                        : ['확률', '통계', '기초'],
              };
              
              return RecommendedProblemCardWidget(
                title: problem['title'] as String,
                difficulty: problem['difficulty'] as String,
                tags: problem['tags'] as List<String>,
                onTap: () {
                  // View problem details
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularProblemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '인기 문제',
              style: TextStyleHelper.instance.title16Medium,
            ),
            CustomButton(
              text: '더보기',
              imagePath: ImageConstant.imgIconChevron,
              imagePosition: CustomImagePosition.right,
              imageSize: Size(18.h, 18.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
              onTap: () {
                // View all popular problems
              },
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            // Sample data for popular problems
            final problem = {
              'title': index == 0
                  ? '2023년 수능 필수 문제 모음'
                  : index == 1
                      ? '수학 기초 개념 정리 문제'
                      : '대학별 기출 문제 모음',
              'category': index == 0 ? '수능' : index == 1 ? '기초' : '대학별',
              'difficulty': index == 0 ? '중상' : index == 1 ? '하' : '상',
              'rating': 4.5 + (index * 0.1),
              'reviewCount': 120 - (index * 30),
            };
            
            return Container(
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                border: Border.all(color: appTheme.gray200),
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Row(
                children: [
                  Container(
                    height: 64.h,
                    width: 64.h,
                    decoration: BoxDecoration(
                      color: appTheme.gray100,
                      borderRadius: BorderRadius.circular(8.h),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyleHelper.instance.title20SemiBold,
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          problem['title'] as String,
                          style: TextStyleHelper.instance.title16Medium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: appTheme.gray100,
                                borderRadius: BorderRadius.circular(4.h),
                              ),
                              child: Text(
                                problem['category'] as String,
                                style: TextStyleHelper.instance.body12SemiBold.copyWith(
                                  color: appTheme.gray900,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: (problem['difficulty'] as String).contains('상')
                                    ? Colors.red.withAlpha(26)
                                    : (problem['difficulty'] as String).contains('중')
                                        ? Colors.orange.withAlpha(26)
                                        : Colors.green.withAlpha(26),
                                borderRadius: BorderRadius.circular(4.h),
                              ),
                              child: Text(
                                problem['difficulty'] as String,
                                style: TextStyleHelper.instance.body12SemiBold.copyWith(
                                  color: (problem['difficulty'] as String).contains('상')
                                      ? Colors.red
                                      : (problem['difficulty'] as String).contains('중')
                                          ? Colors.orange
                                          : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.h,
                            ),
                            SizedBox(width: 4.h),
                            Text(
                              '${problem['rating']}',
                              style: TextStyleHelper.instance.body14Medium,
                            ),
                            SizedBox(width: 8.h),
                            Text(
                              '(${problem['reviewCount']})',
                              style: TextStyleHelper.instance.body14.copyWith(
                                color: appTheme.gray500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
                // Already on home
              },
              isActive: true,
            ),
            _buildBottomNavItem(
              icon: ImageConstant.imgIconCalendar,
              label: '지난 문제',
              onTap: () {
                // Navigate to calendar/past problems
              },
            ),
            _buildBottomNavItem(
              icon: ImageConstant.imgIconWallet,
              label: '문제 고르기',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.problemSearchScreen);
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
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: icon,
            height: 24.h,
            width: 24.h,
            color: isActive ? appTheme.black : null,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyleHelper.instance.body12SemiBold.copyWith(
              color: isActive ? appTheme.black : appTheme.gray500,
            ),
          ),
        ],
      ),
    );
  }
}