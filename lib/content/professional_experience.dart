import 'package:flutter/material.dart';

import '../ui/const.dart';
import '../ui/container/header_expandable.dart';
import '../ui/strings.dart';
import '../ui/text.dart';
import '../ui/theme.dart';
import 'content_group.dart';

class ProfessionalExperienceGroup extends StatelessWidget {
  final bool hasListView;
  final List<Widget> _children = [];

  ProfessionalExperienceGroup(this.hasListView);

  @override
  Widget build(BuildContext context) {
    _addChild(
      AppStrings.fortlevExperienceTitle, AppStrings.fortlevExperiencePeriod,
      Column(
        children: [
          AppIconText(AppIcons.link, 'https://www.bci-consulting.com', false, true),
          AppUiConst.vsep8,
          AppIconText(AppIcons.link, 'https://www.fortlev.com.br', false, true)
        ]
      ),
      AppStrings.fortlevExperienceText, true
    );

    _addChild(
      AppStrings.flutterExperienceTitle, '2021', null,
      AppStrings.flutterExperienceText, true
    );

    _addChild(
      AppStrings.mobileGameExperienceTitle, '2013 - 2020', null,
      AppStrings.mobileGameExperienceText, true
    );

    _addChild(
      AppStrings.santriExperienceTitle, AppStrings.santriExperiencePeriod,
      AppIconText(AppIcons.link, 'https://www.santri.com.br', false, true),
      AppStrings.santriExperienceText, true
    );

    _addChild(
      AppStrings.smallERPTitle, '2006/2007', null,
      AppStrings.smallERPText, false
    );

    return ContentGroup(
      icon: AppIcons.experience,
      title: AppStrings.professionalExperienceTitle,
      hasPadding: false,
      hasListView: hasListView,
      children: _children
    );
  }

  void _addChild(
      String title,
      String period,
      Widget? fixedContent,
      String expandableContent,
      bool addSeparator
    )
  {
    final Widget child = AppHeaderExpandable(
      headerContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.normalDarkBlueBoldStyle),
          Text(period, style: AppTheme.normalDarkBlueItalicStyle)
        ]
      ),
      fixedContent: fixedContent,
      expandableContent: Text(expandableContent, style: AppTheme.normalDarkStyle)
    );
    _children.add(child);

    if (addSeparator)
      _children.add(AppUiConst.vsep16);
  }
}