import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_view.dart';

class SearchSectionWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String detail1;
  final String detail2;
  final VoidCallback onEditPressed;
  final VoidCallback onFilterPressed;
  final VoidCallback onSortPressed;

  const SearchSectionWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.detail1,
    required this.detail2,
    required this.onEditPressed,
    required this.onFilterPressed,
    required this.onSortPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
      color: appTheme.whiteCustom,
      child: Column(
        children: [
          _buildSearchBox(),
          SizedBox(height: 16.h),
          _buildFilterSection(),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: appTheme.colorFFF3F4,
        borderRadius: BorderRadius.circular(12.h),
      ),
      padding: EdgeInsets.all(8.h),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.h, left: 8.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgIconSearch,
                  height: 24.h,
                  width: 24.h,
                ),
              ),
              SizedBox(width: 12.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: TextStyleHelper.instance.title16Medium),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(subtitle, style: TextStyleHelper.instance.body14),
                        _buildDividerDot(),
                        Text(detail1, style: TextStyleHelper.instance.body14),
                        _buildDividerDot(),
                        Text(detail2, style: TextStyleHelper.instance.body14),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 12.h,
            top: 20.h,
            child: GestureDetector(
              onTap: onEditPressed,
              child: CustomImageView(
                imagePath: ImageConstant.imgIconEdit,
                height: 24.h,
                width: 24.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomButton(
              text: 'Filter',
              imagePath: ImageConstant.imgIconChevron,
              imagePosition: CustomImagePosition.right,
              imageSize: Size(18.h, 18.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: appTheme.colorFFE5E7),
                borderRadius: BorderRadius.circular(6.h),
              ),
              onTap: onFilterPressed,
            ),
            SizedBox(width: 8.h),
            CustomButton(
              text: 'Sort',
              imagePath: ImageConstant.imgIconChevron,
              imagePosition: CustomImagePosition.right,
              imageSize: Size(18.h, 18.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: appTheme.colorFFE5E7),
                borderRadius: BorderRadius.circular(6.h),
              ),
              onTap: onSortPressed,
            ),
          ],
        ),
        Text(
          '99 results',
          style: TextStyleHelper.instance.body14.copyWith(
            color: appTheme.blackCustom,
          ),
        ),
      ],
    );
  }

  Widget _buildDividerDot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Container(
        width: 4.h,
        height: 4.h,
        decoration: BoxDecoration(
          color: appTheme.blackCustom,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}