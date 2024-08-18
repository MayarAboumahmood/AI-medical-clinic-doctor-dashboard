import 'package:easy_localization/easy_localization.dart';

String getPHQ9Recommendation(String score) {
  int intScore = 0;
  try {
    intScore = int.parse(score);
  } catch (e) {
    if (score.contains('The patient has')) {
      return '';
    }
    return score.tr();
  }
  if (intScore >= 0 && intScore <= 4) {
    return 'None';
  } else if (intScore >= 5 && intScore <= 9) {
    return 'Watchful waiting; repeat PHQ 9 at follow-up'.tr();
  } else if (intScore >= 10 && intScore <= 14) {
    return 'Review treatment plan if not improving in past 4 weeks; Consider discussion of additional support such as pharmacotherapy'
        .tr();
  } else if (intScore >= 15 && intScore <= 19) {
    return 'Consider adjusting treatment plan and/or frequency of sessions; Discuss additional supports such as pharmacotherapy; For SonderMind Anytime Messaging clients, consider converting from asynchronous to synchronous therapy channels'
        .tr();
  } else if (intScore >= 20 && intScore <= 27) {
    return 'Adjust treatment plan; focused assessment of safety plan and pharmacotherapy evaluation/re-evaluation; If emergent then refer to higher level of care; Likely not a candidate for asynchronous/text therapy'
        .tr();
  } else {
    return 'Invalid score'.tr();
  }
}
