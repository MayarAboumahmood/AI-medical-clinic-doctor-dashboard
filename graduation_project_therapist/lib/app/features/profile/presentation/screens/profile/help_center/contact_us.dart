import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/utils/flutter_flow_util.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 20, 12, 12),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                contactWidget(context, "Customer Service",
                    Icons.miscellaneous_services_sharp),
                contactWidget(
                    context, "WhatsApp", 'assets/images/WhatsApp.png'),
                contactWidget(context, "Website", Icons.language_sharp),
                contactWidget(context, "Facebook", Icons.facebook),
                contactWidget(
                    context, "Twitter", 'assets/images/Twitter_Circled.png'),
                contactWidget(
                  context,
                  "Instagram",
                  'assets/images/Instagram.png',
                ),
              ].divide(const SizedBox(height: 20)),
            ),
          ),
                  ],
      ),
    );
  }

  Row contactWidget(BuildContext context, String title, var iconOrImage) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.secondaryBackGround,
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  iconOrImage is IconData
                      ? Icon(
                          iconOrImage,
                          color: customColors.primary,
                          size: 20,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            iconOrImage,
                            color: customColors.primary,
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Text(
                    title.tr(),
                    style: customTextStyle.displaySmall.copyWith(
                      color: customColors.text2,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ].divide(const SizedBox(width: 5)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
