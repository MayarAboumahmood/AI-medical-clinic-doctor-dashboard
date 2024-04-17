import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/edit_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/widgets/pic_pichter_bottom_sheet_edit_profile.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  DateTime dateTime = DateTime(2000, 1, 1);
  String? selectedGender;
  String? selectedState;
  String? imageURl;
  bool isClickedSave = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initializeUserData();
  }

  Future<UserData?> getUserDataFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_profile')) return null;

    String userProfileString = prefs.getString('user_profile')!;
    Map<String, dynamic> userJson = json.decode(userProfileString);
    return UserData.fromJson(userJson);
  }

  Future<void> initializeUserData() async {
    UserData? userData = await getUserDataFromPrefs();
    if (userData != null) {
      setState(() {
        if (!statesList.contains(userData.state)) {
          selectedState = 'Damascus'.tr();
        } else {
          selectedState = userData.state;
        }
        if (!genderOptions.contains(userData.gender)) {
          selectedGender = 'male'.tr();
        } else {
          selectedGender = userData.gender;
        }
        firstNameController.text = userData.firstname;
        lastNameController.text = userData.lastname;
        String birthDateString = userData.birthDate; // "1999/10/10"
        try {
          if (birthDateString.contains('-')) {
            DateFormat format = DateFormat("yyyy-MM-dd");
            dateTime = format.parse(birthDateString);
          } else if (birthDateString.contains('/')) {
            DateFormat format = DateFormat("yyyy/MM/dd");
            dateTime = format.parse(birthDateString);
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing date: $e');
          }
        }
        imageURl = userData.profilePicture;
      });
    } else {
      // Handle the case where userData is null (e.g., set default values)
      setState(() {
        firstNameController.text = 'first name';
        lastNameController.text = 'last name';
        selectedGender = 'male';
        selectedState = 'Damascus';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is! LoadingRequest) {
        isClickedSave = false;
      }
      if (state is SuccessEditRequest) {
        customSnackBar(
          'Your profile has been updated',
          context,
          shouldFloating: true,
        );

        navigationService.goBack();
      } else if (state is ValidationErrorRequest) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Check your inputs".tr()),
          ),
        );
      }
    }, builder: (context, state) {
      // final isLoading = state is LoadingRequest;
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
                        'fist Name',
                        Icons.person_outline,
                        firstNameController.text,
                        firstNameController,
                        1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      editeInfoTextField(
                        context,
                        'last Name',
                        Icons.person_outline,
                        lastNameController.text,
                        lastNameController,
                        1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      chooseDateWidget(context),
                      const SizedBox(
                        height: 10,
                      ),
                      selectGenderDropDown(),
                      const SizedBox(
                        height: 10,
                      ),
                      selectStateDropDown(),
                      const SizedBox(
                        height: 30,
                      ),
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
            // context.read<ShowProductsBloc>().userState = selectedState;
            setState(() {
              isClickedSave = true;
            });
            formState.save();
            final updatedProfileData = EditProfileModel(
              gender: selectedGender!,
              state: selectedState!,
              profilePic: BlocProvider.of<ProfileBloc>(context).image,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              dateOfBirth: DateFormat('yyyy-MM-dd').format(dateTime),
            );
            BlocProvider.of<ProfileBloc>(context).add(
              EditProfileEvent(editedData: updatedProfileData),
            );
          }
        }, isClickedSave),
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
              },
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
                      DateFormat('yyyy/MM/dd').format(dateTime),
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

  Widget selectGenderDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: customColors.secondaryBackGround)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: DropdownButtonFormField<String>(
            value: selectedGender,
            decoration: InputDecoration(
              hintStyle: customTextStyle.bodyMedium.copyWith(
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: customColors.primary,
                    fontSize: 12,
                  ),
              labelText: 'Gender:'.tr(),
              border: InputBorder.none,
            ),
            dropdownColor: customColors.primaryBackGround,
            items: genderOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value.tr(),
                  style: customTextStyle.bodySmall
                      .copyWith(color: customColors.primaryText),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
              });
            },
          ),
        ),
      ),
    );
  }

  Padding selectStateDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: customColors.secondaryBackGround)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: DropdownButtonFormField<String>(
            value: selectedState,
            decoration: InputDecoration(
              hintText: 'State'.tr(),
              hintStyle: customTextStyle.bodyMedium.copyWith(
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: customColors.primary,
                    fontSize: 12,
                  ),
              labelText: 'State:'.tr(),
              border: InputBorder.none,
            ),
            dropdownColor: customColors.primaryBackGround,
            items: statesList.map<DropdownMenuItem<String>>((String state) {
              return DropdownMenuItem<String>(
                value: state,
                child: Text(
                  state.tr(),
                  style: customTextStyle.bodySmall
                      .copyWith(color: customColors.primaryText),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedState = newValue;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Padding editeInfoTextField(
      BuildContext context,
      String label,
      IconData suffixIcon,
      String hintText,
      TextEditingController controller,
      int textType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: editeProfileTextField(
          textInputType: textType == 1
              ? TextInputType.name
              : textType == 2
                  ? TextInputType.phone
                  : TextInputType.emailAddress,
          controller: controller,
          validator: (value) {
            if (textType == 3) {
              if (controller.text.isNotEmpty) {
                return ValidationFunctions.isValidEmail(value);
              }
            } else if (textType == 2) {
              return ValidationFunctions.validateSyrianPhoneNumber(value);
            } else if (textType == 1) {
              return ValidationFunctions.nameValidation(value);
            }
            return null;
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
                  ? Image.file(imageFile)
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

List<String> statesList = [
  'Damascus'.tr(),
  'Homs'.tr(),
  'Latakia'.tr(),
  'Aleppo'.tr(),
  'Tartus'.tr(),
  'As-suwayda'.tr(),
]; // Add your states here
List<String> genderOptions = [
  'male'.tr(),
  'female'.tr()
]; // List of gender options
