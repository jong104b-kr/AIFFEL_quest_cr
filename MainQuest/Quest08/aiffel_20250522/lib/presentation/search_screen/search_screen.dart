import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';

// /home/ubuntu/app/byun_s_application/lib/presentation/search_screen/search_screen.dart






class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime selectedDate = DateTime.now();
  int roomCount = 1;
  int guestCount = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteCustom,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPreviousExamFormatTab(),
                  _buildProblemBankFormatTab(),
                ],
              ),
            ),
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
            Navigator.pop(context);
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

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.grey200,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: appTheme.black,
        unselectedLabelColor: appTheme.gray500,
        labelStyle: TextStyleHelper.instance.body14Medium,
        indicatorColor: appTheme.black,
        indicatorWeight: 2,
        tabs: [
          Tab(text: '기출문제 형식으로 풀기'), // Previous exam format
          Tab(text: '문제은행식 문제 풀기'), // Problem bank format
        ],
      ),
    );
  }

  Widget _buildPreviousExamFormatTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(
              title: '기출문제 형식으로 풀기',
              onSearch: () {
                // Handle search action
              },
            ),
            SizedBox(height: 24.h),
            _buildDateSelector(),
            SizedBox(height: 16.h),
            _buildRoomGuestSelector(),
            SizedBox(height: 24.h),
            _buildFilterSortSection(97), // 97 results
            SizedBox(height: 16.h),
            _buildResultsList('previous'),
          ],
        ),
      ),
    );
  }

  Widget _buildProblemBankFormatTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(
              title: '문제은행식 문제 풀기',
              onSearch: () {
                // Handle search action
              },
            ),
            SizedBox(height: 24.h),
            _buildDateSelector(),
            SizedBox(height: 16.h),
            _buildRoomGuestSelector(),
            SizedBox(height: 24.h),
            _buildFilterSortSection(103), // 103 results
            SizedBox(height: 16.h),
            _buildResultsList('bank'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar({required String title, required VoidCallback onSearch}) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: appTheme.colorFFF3F4,
        borderRadius: BorderRadius.circular(12.h),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconSearch,
            height: 24.h,
            width: 24.h,
            color: appTheme.gray500,
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: title,
                hintStyle: TextStyleHelper.instance.body14.copyWith(color: appTheme.gray500),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              style: TextStyleHelper.instance.body14Medium,
              onSubmitted: (value) => onSearch(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    final formattedDate = '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('날짜 선택', style: TextStyleHelper.instance.title16Medium),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2025),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: appTheme.gray200),
              borderRadius: BorderRadius.circular(8.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: TextStyleHelper.instance.body14Medium,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconCalendar,
                  height: 24.h,
                  width: 24.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomGuestSelector() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('교실 수', style: TextStyleHelper.instance.title16Medium),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: appTheme.gray200),
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$roomCount 교실',
                      style: TextStyleHelper.instance.body14Medium,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (roomCount > 1) roomCount--;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.h),
                            decoration: BoxDecoration(
                              color: appTheme.gray200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.remove, size: 16.h),
                          ),
                        ),
                        SizedBox(width: 8.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              roomCount++;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.h),
                            decoration: BoxDecoration(
                              color: appTheme.gray200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, size: 16.h),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('학생 수', style: TextStyleHelper.instance.title16Medium),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: appTheme.gray200),
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$guestCount 학생',
                      style: TextStyleHelper.instance.body14Medium,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (guestCount > 1) guestCount--;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.h),
                            decoration: BoxDecoration(
                              color: appTheme.gray200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.remove, size: 16.h),
                          ),
                        ),
                        SizedBox(width: 8.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              guestCount++;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.h),
                            decoration: BoxDecoration(
                              color: appTheme.gray200,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, size: 16.h),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSortSection(int resultCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomButton(
              text: '필터',
              imagePath: ImageConstant.imgIconChevron,
              imagePosition: CustomImagePosition.right,
              imageSize: Size(18.h, 18.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: appTheme.colorFFE5E7),
                borderRadius: BorderRadius.circular(6.h),
              ),
              onTap: () {
                // Handle filter action
              },
            ),
            SizedBox(width: 8.h),
            CustomButton(
              text: '정렬',
              imagePath: ImageConstant.imgIconChevron,
              imagePosition: CustomImagePosition.right,
              imageSize: Size(18.h, 18.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: appTheme.colorFFE5E7),
                borderRadius: BorderRadius.circular(6.h),
              ),
              onTap: () {
                // Handle sort action
              },
            ),
          ],
        ),
        Text(
          '$resultCount 결과',
          style: TextStyleHelper.instance.body14.copyWith(
            color: appTheme.blackCustom,
          ),
        ),
      ],
    );
  }

  Widget _buildResultsList(String type) {
    // Mock data for problem items
    final items = List.generate(
      5,
      (index) => {
        'title': type == 'previous' 
            ? '${index + 1}. 2023년 6월 모의고사 수학 문제' 
            : '${index + 1}. 삼각함수 응용 문제 세트',
        'subtitle': type == 'previous'
            ? '2023년 6월 모의고사'
            : '삼각함수 응용',
        'difficulty': '난이도: ${index % 3 == 0 ? '상' : index % 3 == 1 ? '중' : '하'}',
        'tags': ['수학', index % 2 == 0 ? '기하' : '대수', '모의고사'],
      },
    );

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: appTheme.gray200),
            borderRadius: BorderRadius.circular(8.h),
          ),
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: TextStyleHelper.instance.title16Medium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: item['difficulty'].toString().contains('상')
                          ? Colors.red.withAlpha(26)
                          : item['difficulty'].toString().contains('중')
                              ? Colors.orange.withAlpha(26)
                              : Colors.green.withAlpha(26),
                      borderRadius: BorderRadius.circular(4.h),
                    ),
                    child: Text(
                      item['difficulty'] as String,
                      style: TextStyleHelper.instance.body12SemiBold.copyWith(
                        color: item['difficulty'].toString().contains('상')
                            ? Colors.red
                            : item['difficulty'].toString().contains('중')
                                ? Colors.orange
                                : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                item['subtitle'] as String,
                style: TextStyleHelper.instance.body14.copyWith(color: appTheme.gray500),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.h,
                runSpacing: 8.h,
                children: (item['tags'] as List).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: appTheme.gray100,
                      borderRadius: BorderRadius.circular(4.h),
                    ),
                    child: Text(
                      tag as String,
                      style: TextStyleHelper.instance.body12SemiBold.copyWith(
                        color: appTheme.gray900,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
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
                // Navigate to wallet - current screen
              },
              isActive: true,
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