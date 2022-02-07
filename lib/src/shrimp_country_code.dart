import 'package:flutter/material.dart';
import 'circle_radio_otpion.dart';
import 'country_data.dart';
import 'country_info.dart';

class ShrimpCountryCode extends StatefulWidget {
  final double padding;
  final double radius;
  final double modalToRadius;
  final bool showFlags;
  final String modalTitle;
  final String? searchFieldHint;
  final InputDecoration? inputDecoration;
  final String? initialCountry;
  final ValueChanged<CountryInfo>? onChanged;

  /// Background color of ModalBottomSheet
  final Color? backgroundColor;

  const ShrimpCountryCode({
    Key? key,
    this.padding = 10,
    this.radius = 8,
    this.modalToRadius = 30,
    this.onChanged,
    this.inputDecoration,
    required this.modalTitle,
    this.initialCountry,
    this.backgroundColor,
    this.searchFieldHint,
    this.showFlags = true,
  }) : super(key: key);

  @override
  State<ShrimpCountryCode> createState() => _ShrimpCountryCodeState();
}

class _ShrimpCountryCodeState extends State<ShrimpCountryCode> {
  late List<CountryInfo> countryList;
  late CountryInfo selectedCountry;
  List<CountryInfo> filteredElements = [];

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  _onInit() {
    countryList =
        countries_data.map((json) => CountryInfo.fromJson(json)).toList();
    _setInitialCountry();
  }

  _setInitialCountry() {
    if (widget.initialCountry != null) {
      selectedCountry = countryList
          .firstWhere((element) => element.shortName == widget.initialCountry);
    } else {
      selectedCountry = CountryInfo(
        dialCode: '218',
        shortName: 'LY',
        name: 'Libya',
        displayName: 'Libya (LY) [+218]',
      );
    }
  }

  _updateSelection(CountryInfo e) {
    if (widget.onChanged != null) {
      widget.onChanged!(e);
    }
    setState(() {
      selectedCountry = e;
    });
    Navigator.pop(context);
  }

  _filterCountries(String keyWord) {
    keyWord = keyWord.toUpperCase();
    setState(() {
      filteredElements = countryList
          .where((e) =>
              e.dialCode!.contains(keyWord) ||
              e.shortName!.contains(keyWord) ||
              e.name!.toUpperCase().contains(keyWord))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          backgroundColor: widget.backgroundColor ?? Colors.white,
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(widget.modalToRadius),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _bottomSheetHeader(context),
                        _bottomSheetSearchBox(),
                        _bottomSheetCountryList(setState)
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F3),
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Text('+${selectedCountry.dialCode}'),
          ),
        ),
      ),
    );
  }

  Expanded _bottomSheetCountryList(StateSetter setState) {
    return Expanded(
      child: ListView.builder(
          itemCount: filteredElements.isNotEmpty
              ? filteredElements.length
              : countryList.length,
          itemBuilder: (BuildContext context, int index) {
            CountryInfo country = filteredElements.isNotEmpty
                ? filteredElements[index]
                : countryList[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    _updateSelection(country);
                  },
                  child: Column(
                    children: [
                      _countyCell(country, setState, index),
                    ],
                  ),
                ),
                const Divider()
              ],
            );
          }),
    );
  }

  Row _countyCell(CountryInfo country, StateSetter setState, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              if (widget.showFlags)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image(
                      image: AssetImage(country.flagUrl,
                          package: 'shrimp_country_code'),
                      width: 27,
                    ),
                  ),
                ),
              Expanded(
                child: Text(
                    ' ${country.localizedName(context)} (+${country.dialCode})',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false),
              ),
            ],
          ),
        ),
        CircleRadioOption<CountryInfo>(
          onChanged: (CountryInfo? value) {
            _updateSelection(country);
          },
          groupValue: selectedCountry,
          value: filteredElements.isNotEmpty
              ? filteredElements[index]
              : countryList[index],
        ),
      ],
    );
  }

  Column _bottomSheetSearchBox() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            onChanged: (String keyWord) {
              _filterCountries(keyWord);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: widget.searchFieldHint,
            ),
          ),
        ),
        const Divider()
      ],
    );
  }

  Row _bottomSheetHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: SizedBox(),
          flex: 2,
        ),
        Expanded(
          child: Center(
              child: Text(
            widget.modalTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
          flex: 2,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
