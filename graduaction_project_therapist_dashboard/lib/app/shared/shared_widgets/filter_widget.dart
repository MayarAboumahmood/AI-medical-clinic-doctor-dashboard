import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/filter_bloc/bloc/filter_bloc_bloc.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterWidget extends StatefulWidget {
  final VoidCallback onClearFilters;

  final Function(double distance, double priceRangeEnd, double priceRangeStart,
      List<String> cuisines) onApplyFilters;

  const FilterWidget({
    super.key,
    required this.onApplyFilters,
    required this.onClearFilters,
  });

  @override
  FilterWidgetState createState() => FilterWidgetState();
}

class FilterWidgetState extends State<FilterWidget> {
  double sliderValueDistance = 0;
  double sliderValuePricerangeStart = 0;
  double sliderValuePricerangeEnd = 2000000;
  @override
  initState() {
    super.initState();
    context.read<FilterBlocBloc>().add(const GetFilterCuisineEvent());
  }

  void _applyFilters() {
    widget.onApplyFilters(
        sliderValueDistance,
        sliderValuePricerangeEnd > 1000000
            ? getPriceNumberToShow(sliderValuePricerangeEnd)
            : sliderValuePricerangeEnd,
        sliderValuePricerangeStart > 1000000
            ? getPriceNumberToShow(sliderValuePricerangeStart)
            : sliderValuePricerangeStart,
        []);
    Navigator.pop(context); // Close the modal if needed
  }

  void _clearFilters() {
    widget.onClearFilters();
    setState(() {
      sliderValueDistance = 0;
      sliderValuePricerangeEnd = 2000000;
      sliderValuePricerangeStart = 0;
      // selectedCuisineTypes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBlocBloc, FilterBlocState>(
      builder: (context, state) {
        return buildFilterBody();
      },
    );
  }

  Container buildFilterBody() {
    return Container(
      height: responsiveUtil.screenHeight * .6,
      decoration: BoxDecoration(
        color: customColors.primaryBackGround,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: customColors.shadow,
            offset: const Offset(0, -2),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Filter'.tr(),
                  style: customTextStyle.titleMedium.copyWith(
                      color: customColors.text2, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                thickness: 2,
                color: customColors.secondaryBackGround,
              ),
              Divider(
                thickness: 2,
                color: customColors.secondaryBackGround,
              ),
              const SizedBox(
                height: 10,
              ),
              _buildDistanceValueSlider('Distance by meter'),
              _buildPriceRangeSlider('Price range by S.P'),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Padding circularProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircularProgressIndicator(color: customColors.primary),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: customColors.primary, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: customColors.primaryBackGround),
            child: GestureDetector(
              onTap: _clearFilters,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Text('Clear'.tr(),
                      style: TextStyle(
                        color: customColors.primary,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            width: responsiveUtil.screenWidth * .15,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: customColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: GestureDetector(
              onTap: _applyFilters,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Text('Apply'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceValueSlider(String title) {
    double min = 0;
    double max = 20000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title.tr(),
            style:
                customTextStyle.labelLarge.copyWith(color: customColors.text2),
          ),
        ),
        SfSlider(
          tooltipTextFormatterCallback:
              (dynamic actualValue, String formattedText) {
            if (actualValue < 1000) {
              return '${actualValue.toInt()} m';
            } else {
              return '${(actualValue / 1000).toStringAsFixed(1)} km';
            }
          },
          min: min,
          max: max,
          value: sliderValueDistance,
          onChanged: (value) {
            setState(() {
              sliderValueDistance = value;
            });
          },
          enableTooltip: true,
          activeColor: customColors.primary,
          inactiveColor: customColors.secondaryBackGround,
        ),
      ],
    );
  }

  Widget _buildPriceRangeSlider(String title) {
    double min = 0;
    double max = 2000000;
    double firstDivisionMax = 1000000;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title.tr(),
            style:
                customTextStyle.labelLarge.copyWith(color: customColors.text2),
          ),
        ),
        RangeSlider(
          min: min,
          max: max,
          values:
              RangeValues(sliderValuePricerangeStart, sliderValuePricerangeEnd),
          onChanged: (RangeValues values) {
            setState(() {
              sliderValuePricerangeStart = values.start;
              sliderValuePricerangeEnd = values.end;
            });
          },
          labels: priceLabels(firstDivisionMax),
          divisions: 100,
          activeColor: customColors.primary,
          inactiveColor: customColors.secondaryBackGround,
        ),
      ],
    );
  }

  RangeLabels priceLabels(double firstDivisionMax) {
    return RangeLabels(
      sliderValuePricerangeStart >= firstDivisionMax
          ? '${((getPriceNumberToShow(sliderValuePricerangeStart) ~/ 1000000)).toString()} m ${'SP'.tr()}'
          : '${(sliderValuePricerangeStart).toString()} ${'SP'.tr()}',
      sliderValuePricerangeEnd >= firstDivisionMax
          ? '${((getPriceNumberToShow(sliderValuePricerangeEnd) ~/ 1000000)).toString()} m ${'SP'.tr()}'
          : '${(sliderValuePricerangeEnd).toString()} ${'SP'.tr()}',
    );
  }

  double getPriceNumberToShow(double numberBetweenOneAndTwoMillion) {
    return 4 * numberBetweenOneAndTwoMillion - 3000000;
  }
}
