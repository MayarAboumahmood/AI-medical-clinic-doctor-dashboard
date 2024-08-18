import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/bloc/home_page_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';

import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/widgets/pic_pichter_bottom_sheet_edit_profile.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/format_the_syrain_number.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/select_state_drop_down.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/selected_gender_drop_down.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specInfoController = TextEditingController();
  final TextEditingController studyInfoController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  DateTime dateTime = DateTime(2000, 1, 1);
  String? selectedGender;
  String? selectedState;
  String? imageURl;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeUserData();
  }

  Future<UserProfileModel?> getUserDataFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_profile')) {
      debugPrint("user profile key don't have data");
      return null;
    }

    String userProfileString = prefs.getString('user_profile')!;
    Map<String, dynamic> userJson = json.decode(userProfileString);
    return UserProfileModel.fromMap(userJson);
  }

  DateTime parseDate(String dateString) {
    debugPrint('Received date string: $dateString');
    if (dateString.contains('-')) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      try {
        DateTime dateTime = format.parse(dateString);
        return dateTime;
      } catch (e) {
        debugPrint('Error parsing date: $e');
        return DateTime.now();
      }
    } else if (dateString.contains('/')) {
      DateFormat format = DateFormat("yyyy/MM/dd");
      try {
        DateTime dateTime = format.parse(dateString);
        return dateTime;
      } catch (e) {
        debugPrint('Error parsing date: $e');
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  getGenderString(bool genderBoolean) {
    if (genderBoolean) {
      return 'male'.tr();
    }
    return 'female'.tr();
  }

  Future<void> initializeUserData() async {
    UserProfileModel? userData = await getUserDataFromPrefs();
    if (userData != null) {
      setState(() {
        if (!citiesList.contains(userData.state)) {
          selectedState = 'Damascus'.tr();
        } else {
          selectedState = userData.state;
        }
        if (!genderOptions.contains(getGenderString(userData.gender))) {
          selectedGender = 'male'.tr();
        } else {
          selectedGender = getGenderString(userData.gender);
        }
        nameController.text = userData.fullName;
        studyInfoController.text = userData.studyInfo ?? '';
        specInfoController.text = userData.specInfo ?? '';
        phoneNumberController.text =
            formatSyrianPhoneNumberForMakeItStartWIth09(userData.phone);
        String birthDateString = userData.dateOfBirth; // "1999/10/10"
        try {
          dateTime = parseDate(birthDateString);
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing date: $e');
          }
        }
        imageURl = userData.photo;
      });
    } else {
      // Handle the case where userData is null (e.g., set default values)
      setState(() {
        nameController.text = 'first name'.tr();
        studyInfoController.text = 'Your study info'.tr();
        specInfoController.text = 'Your Spec info'.tr();
        selectedGender = 'male'.tr();
        selectedState = 'Damascus'.tr();
        phoneNumberController.text = '09...'.tr();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is SuccessEditRequest) {
        customSnackBar(
          'Your profile has been updated',
          context,
          isFloating: true,
        );
        context
            .read<HomePageBloc>()
            .add(GetUserInfoEvent(shouldLoadTheUserInfo: true));
        navigationService.goBack();
      } else if (state is ServerErrorRequest) {
        customSnackBar(
          state.errorMessage,
          context,
          isFloating: true,
        );
      }
    }, builder: (context, state) {
      isLoading = state is LoadingRequest;
      return Scaffold(
        backgroundColor: customColors.primaryBackGround,
        body: Form(
          key: formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Edit Profile'.tr(),
                        style: customTextStyle.titleLarge.copyWith(
                            color: customColors.text2,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Below, your profile details'.tr(),
                        style: customTextStyle.titleSmall.copyWith(
                            color: customColors.secondaryText,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [buildImageAndChangeButton(imageURl)],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      editeInfoTextField(
                        context,
                        'Your name',
                        Icons.person_outline,
                        nameController.text,
                        nameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      editeInfoTextField(
                        context,
                        canBeEmpty: true,
                        'Studies information',
                        Icons.person_outline,
                        studyInfoController.text,
                        studyInfoController,
                        isName: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      editeInfoTextField(
                        context,
                        canBeEmpty: true,
                        'Specialization information',
                        Icons.person_outline,
                        specInfoController.text,
                        specInfoController,
                        isName: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: editeProfileTextField(
                          context: context,
                          label: 'phone number',
                          textInputType: TextInputType.number,
                          controller: phoneNumberController,
                          validator: (value) {
                            return ValidationFunctions.isValidSyrianPhoneNumber(
                              formatSyrianPhoneNumberForMakeItStartWIth09(
                                  value!),
                            );
                          },
                          hintText: 'enter your updated phone number',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      chooseDateWidget(context),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: selectGenderDropDown(
                          selectedGender,
                          (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: selectCityDropDown(selectedState,
                            (String? newValue) {
                          setState(() {
                            selectedState = newValue;
                          });
                        }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // selecteLocationOnMapButton(),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildDoneCancelButtons(context),
                      const SizedBox(
                        height: 100,
                      )
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  Padding selecteLocationOnMapButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GeneralButtonOptions(
          text: 'Change Location on Map',
          onPressed: () {
            navigationService.navigateTo(selectLocationMapPage);
          },
          options: ButtonOptions(
              color: customColors.primary,
              width: responsiveUtil.screenWidth,
              maxLines: 1,
              textStyle: customTextStyle.bodyMedium)),
    );
  }

  Row buildDoneCancelButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cancelButtons(context, 'Cancel', () {
          navigationService.goBack();
        }),
        SizedBox(
          width: responsiveUtil.screenWidth * .1,
        ),
        saveButton(context, 'Save changes', () {
          FormState? formState = formKey.currentState;
          if (formState!.validate()) {
            formState.save();
            final updatedProfileData = EditProfileModel(
              gender: selectedGender!,
              state: selectedState!,
              imageName: context.read<ProfileBloc>().imageName,
              profilePic: BlocProvider.of<ProfileBloc>(context).image,
              fullName: nameController.text,
              dateOfBirth: DateFormat('yyyy-MM-dd').format(dateTime),
              phoneNumber: formatSyrianPhoneNumberForMakeItStartWIth09(
                  phoneNumberController.text),
              latitude: '0',
              longitude: '0',
              specInfo: specInfoController.text,
              studyInfo: studyInfoController.text,
            );
            BlocProvider.of<ProfileBloc>(context).add(
              EditProfileEvent(editedData: updatedProfileData),
            );
          }
        }, isLoading),
      ],
    );
  }

  Padding chooseDateWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: GestureDetector(
          onTap: () {
            buildChooseDate(
              context,
              dateTime,
              (newDateTime) {
                setState(() {
                  dateTime = newDateTime;
                });
                navigationService.goBack();
              },DatePickType.birthDay
            );
          },
          child: Container(
            height: 50,
            width: responsiveUtil.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: customColors.secondaryBackGround)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      'Date Of Birth: '.tr(),
                      style: customTextStyle.bodyMedium.copyWith(
                        color: customColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(dateTime),
                      style: customTextStyle.bodyMedium.copyWith(
                        color: customColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.date_range,
                      color: customColors.primaryText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    specInfoController.dispose();
    studyInfoController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Padding editeInfoTextField(BuildContext context, String label,
      IconData suffixIcon, String hintText, TextEditingController controller,
      {bool isName = true, bool canBeEmpty = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: editeProfileTextField(
          textInputType: TextInputType.name,
          controller: controller,
          validator: (value) {
            return isName
                ? ValidationFunctions.nameValidation(value)
                : canBeEmpty
                    ? ValidationFunctions.informationValidationThatCanBeEmpty(
                        value)
                    : ValidationFunctions.informationValidation(value);
          },
          context: context,
          suffixIcon: Icon(suffixIcon, color: customColors.text2, size: 22),
          hintText: hintText,
          label: label.tr()),
    );
  }
}

Widget buildImageAndChangeButton(String? imageURL) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      File? imageFile;

      if (state is SelectEditProfilePicture) {
        imageFile = state.picture;
      }

      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: customColors.alternate, // Red border color
                width: 2.0, // Border width
              ),
            ),
            child: Container(
              width: 90,
              height: 90,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: imageFile != null
                  ? kIsWeb
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(
                              context.read<ProfileBloc>().imageInBytes),
                        )
                      : Image.file(imageFile)
                  : imageURL != null
                      ? imageLoader(
                          url: imageURL,
                          width: responsiveUtil.scaleWidth(90),
                          height: responsiveUtil.scaleWidth(90),
                          fit: BoxFit.cover,
                        )
                      : const Center(child: Icon(Icons.add_a_photo)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              await showBottomSheetWidget(
                context,
                buildimageSourcesBottomSheetForEditProfile(context),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: customColors.primaryBackGround,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: customColors
                      .secondaryBackGround, // Replace with your desired color
                  width: 1.5, // Adjust the width as needed
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Change Photo'.tr(),
                  style: customTextStyle.bodyMedium
                      .copyWith(color: customColors.text2),
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}

Widget saveButton(BuildContext context, String title,
    dynamic Function()? onPressed, bool isLoading) {
  return GeneralButtonOptions(
    onPressed: onPressed,
    loading: isLoading,
    options: ButtonOptions(
      width: responsiveUtil.screenWidth * .38,
      borderRadius: BorderRadius.circular(10),
      color: customColors.primary,
      textStyle: customTextStyle.titleSmall.copyWith(
        color: Colors.white, // customColors.primaryBackGround,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
    text: title.tr(),
  );
}

GestureDetector cancelButtons(
  BuildContext context,
  String title,
  dynamic Function()? onPressed,
) {
  bool isDeleteButton = title == 'Cancel';
  return GestureDetector(
    onTap: onPressed,
    child: SizedBox(
      width: responsiveUtil.screenWidth * .38,
      child: Card(
        color: isDeleteButton
            ? customColors.primaryBackGround
            : customColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isDeleteButton ? customColors.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: responsiveUtil.screenWidth > 300 ? 20 : 10,
              vertical: 10),
          child: Center(
              child: Text(
            title.tr(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: customTextStyle.titleSmall.copyWith(
              color: isDeleteButton ? customColors.primary : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          )),
        ),
      ),
    ),
  );
}
