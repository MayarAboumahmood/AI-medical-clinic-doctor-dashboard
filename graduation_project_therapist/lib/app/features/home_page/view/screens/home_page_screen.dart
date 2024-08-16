import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/bloc/home_page_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:path/path.dart' as p; // Alias this package as 'p'
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  late HomePageBloc homePageBloc;

  @override
  void initState() {
    homePageBloc = context.read<HomePageBloc>();
    homePageBloc.add(GetUserInfoEvent());
    homePageBloc.add(GetUserStatusEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is HomePageInitial) {
          print('home page init state');
        } else if (state is FetchDataFauilerState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        }
      },
      child: Scaffold(
        backgroundColor: customColors.primaryBackGround,
        body: Screenshot(
          controller: screenshotController,
          child: GestureDetector(
            onTap: () {
              takeScreenshot(context, screenshotController);
            },
            child: BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                return SizedBox(
                  height: responsiveUtil.screenHeight * .3,
                  width: responsiveUtil.screenWidth * .3,
                  child: Center(
                      child: Text(
                    userStatus.name.tr(),
                    style: customTextStyle.bodyMedium,
                  )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<Directory?> getScreenshotsDirectory() async {
  if (Platform.isAndroid) {
    print('Screenshot taken: andriod');
    // Get the directory for external storage
    final externalDir = await getDownloadsDirectory();
    if (externalDir != null) {
      // Define the path for the new folder
      final customDirPath = p.join(externalDir.path, 'Smart Therapist System');

      // Create the directory if it doesn't exist
      final customDir = Directory(customDirPath);
      if (await customDir.exists() == false) {
        await customDir.create(recursive: true);
      }
      print('Screenshot taken: customDir$customDir');
      return customDir;
    }
  } else if (Platform.isIOS) {
    // For iOS, use the application's document directory
    return await getApplicationDocumentsDirectory();
  }
  print('Screenshot taken: nulllllllllll');

  return null;
}

// Function to take a screenshot
void takeScreenshot(
    BuildContext context, ScreenshotController screenshotController) async {
  // Capture the screenshot

  final image = await screenshotController.capture();

  if (image != null) {
    // Save the screenshot to a file or do something with the image
    print('Screenshot taken!: ${image.length}');

    final directory = await getScreenshotsDirectory();

    if (directory != null) {
      // Create a unique filename for the screenshot
      String fileName =
          "screenshot_${DateTime.now().millisecondsSinceEpoch}.png";
      String filePath = p.join(directory.path, fileName);

      // Save the image to the screenshots folder
      final file = File(filePath);
      await file.writeAsBytes(image);

      print('Screenshot saved to $filePath');
      // Optionally, you can show a snackbar or alert to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Screenshot saved to $filePath')),
      );
      // You can save the image to the device or share it
    }
  }
}
