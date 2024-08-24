import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/utils/flutter_flow_util.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/widgets/form_field_controller.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/widgets/help_center_category_chip.dart';

import '../../../../../../../main.dart';
import '../../../../../../shared/shared_widgets/text_related_widget/text_fields/search_text_field.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  FAQState createState() => FAQState();
}

class FAQState extends State<FAQ> {
  final List<FAQItem> faqItems = [
    FAQItem("SMC_intro", "SMC_intro_description", 'General'),
    FAQItem("SMC_functions", "SMC_functions_description", 'General'),
    FAQItem("register_login", "register_login_description", "Account"),
    FAQItem("search_SMC", "search_SMC_description", "Service"),
    FAQItem("booking_process", "booking_process_description", "Service"),
    FAQItem(
        "manage_reservations", "manage_reservations_description", "Account"),
    FAQItem("payment_methods", "payment_methods_description", "Payment"),
    FAQItem("payment_security", "payment_security_description", "Payment"),
    FAQItem("user_support", "user_support_description", "Service"),
    FAQItem("data_protection", "data_protection_description", 'General'),
    FAQItem("access_delete_data", "access_delete_data_description", "Account"),
  ];
  late List<FAQItem> filteredFAQItems;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    filteredFAQItems = List.from(faqItems);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void filterByCategories(String selectedCategory) {
    setState(() {
      if (selectedCategory == '') {
        filteredFAQItems = faqItems;
      } else {
        filteredFAQItems = faqItems
            .where((item) => selectedCategory.tr().contains(item.category.tr()))
            .toList();
      }
    });
  }

  void search(String query) {
    setState(() {
      filteredFAQItems = faqItems
          .where((item) =>
              item.question
                  .tr()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()) ||
              item.answer.tr().toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FadingEdgeScrollView.fromSingleChildScrollView(
        gradientFractionOnEnd: 0.5,
        gradientFractionOnStart: 0,
        // shouldDisposeScrollController: true,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              ChipsC(
                selectCategory: (categoryName) {
                  filterByCategories(categoryName);
                },
              ),
              SingleChildScrollView(
                padding: responsiveUtil.padding(16, 16, 0, 16),
                child: Column(
                  children: [
                    searchTextField(
                      hintText: 'Search...',
                      onChanged: search,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: filteredFAQItems.map((item) {
                            return question(
                                context, item.question, item.answer);
                          }).divide(const SizedBox(height: 20)),
                        ),
                      ),
                    )
                  ].divide(const SizedBox(
                    height: 16,
                  )),
                ),
              ),
              const SizedBox(
                height: 90,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row question(BuildContext context, String question, String answer) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.secondaryBackGround,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Container(
                width: double.infinity,
                color: const Color(0x00000000),
                child: ExpandableNotifier(
                  controller: ExpandableController(initialExpanded: false),
                  child: ExpandablePanel(
                    header: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.00, -1.00),
                          child: Text(
                            question.tr(),
                            style: customTextStyle.displaySmall.copyWith(
                              color: customColors.text2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    collapsed: Container(
                      width: MediaQuery.sizeOf(context).width * 0,
                      height: 0,
                      decoration: const BoxDecoration(),
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1,
                          color: customColors.primary,
                        ),
                        Text(
                          answer.tr(),
                          style: customTextStyle.bodyMedium.copyWith(
                            color: customColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor: customColors.secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FAQItem {
  final String question;
  final String answer;
  final String category;

  FAQItem(
    this.question,
    this.answer,
    this.category,
  );
}

class ChipsC extends StatefulWidget {
  final Function(String filterdList) selectCategory;

  const ChipsC({super.key, required this.selectCategory});

  @override
  State<ChipsC> createState() => _ChipsCState();
}

class _ChipsCState extends State<ChipsC> {
  // ignore: prefer_typing_uninitialized_variables
  var choiceChipsValue;
  String prevValue = '';
  FormFieldController<List<String>>? choiceChipsValueController;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: buildListOfCategoryChip());
  }

  Wrap buildListOfCategoryChip() {
    return Wrap(children: [
      helpCenterCategoryChip('General', prevValue, (selectedCategory) {
        selectCategory(selectedCategory);
      }),
      helpCenterCategoryChip('Payment', prevValue, (selectedCategory) {
        selectCategory(selectedCategory);
      }),
      helpCenterCategoryChip('Account', prevValue, (selectedCategory) {
        selectCategory(selectedCategory);
      }),
      helpCenterCategoryChip('Service', prevValue, (selectedCategory) {
        selectCategory(selectedCategory);
      }),
    ]);
  }

  void selectCategory(String selectedCategory) {
    if (prevValue != selectedCategory) {
      prevValue = selectedCategory;
      widget.selectCategory(selectedCategory);
    } else {
      prevValue = '';
      widget.selectCategory('');
    }
  }
}
