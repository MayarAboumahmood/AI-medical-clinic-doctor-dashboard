import 'package:easy_localization/easy_localization.dart';

String getPHQ9Recommendation(int score) {
  if (score >= 0 && score <= 4) {
    return 'None';
  } else if (score >= 5 && score <= 9) {
    return 'Watchful waiting; repeat PHQ 9 at follow-up'.tr();
  } else if (score >= 10 && score <= 14) {
    return 'Review treatment plan if not improving in past 4 weeks; Consider discussion of additional support such as pharmacotherapy'
        .tr();
  } else if (score >= 15 && score <= 19) {
    return 'Consider adjusting treatment plan and/or frequency of sessions; Discuss additional supports such as pharmacotherapy; For SonderMind Anytime Messaging clients, consider converting from asynchronous to synchronous therapy channels'
        .tr();
  } else if (score >= 20 && score <= 27) {
    return 'Adjust treatment plan; focused assessment of safety plan and pharmacotherapy evaluation/re-evaluation; If emergent then refer to higher level of care; Likely not a candidate for asynchronous/text therapy'
        .tr();
  } else {
    return 'Invalid score'.tr();
  }
}
