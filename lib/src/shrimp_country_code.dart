import 'package:flutter/material.dart';
import 'package:shrimp_country_code/src/country.dart';

import 'circle_radio_otpion.dart';
import 'country_info.dart';

class ShrimpCountryCode extends StatefulWidget {
  const ShrimpCountryCode(
      {Key? key,
      this.padding = 10,
      this.radius = 8,
      this.onChanged,
      this.inputDecoration,
      required this.modalTitle})
      : super(key: key);

  final double padding;
  final double radius;
  final String modalTitle;
  final InputDecoration? inputDecoration;
  final ValueChanged<CountryInfo>? onChanged;

  @override
  State<ShrimpCountryCode> createState() => _ShrimpCountryCodeState();
}

class _ShrimpCountryCodeState extends State<ShrimpCountryCode> {
  late List<CountryInfo> countryList;
  late CountryInfo selectedCountry;
  List<CountryInfo> filteredElements = [];

  @override
  void initState() {
    List<CountryInfo> elements =
        countryInfo.map((json) => CountryInfo.fromJson(json)).toList();

    countryList = elements;
    selectedCountry = CountryInfo(
        dialCode: '218',
        shortName: 'LY',
        name: 'Libya',
        displayName: 'display_name');
    super.initState();
  }

  void _updateSelection(CountryInfo e) {
    if (widget.onChanged != null) {
      widget.onChanged!(e);
      setState(() {
        selectedCountry = e;
      });
    }
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = countryList
          .where((e) =>
              e.dialCode!.contains(s) ||
              e.shortName!.contains(s) ||
              e.name!.toUpperCase().contains(s))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                                flex: 2,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          onChanged: (String keyWord) {
                            _filterElements(keyWord);
                          },
                          decoration: widget.inputDecoration,
                        ),
                        Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: filteredElements.isNotEmpty
                                  ? filteredElements.length
                                  : countryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                CountryInfo country =
                                    filteredElements.isNotEmpty
                                        ? filteredElements[index]
                                        : countryList[index];
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedCountry = country;
                                        });
                                        _updateSelection(country);
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  4.0),
                                                          child: Image(
                                                            image: AssetImage(
                                                                'flags/${country.shortName.toString().toLowerCase()}.png'),
                                                            width: 27,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            ' ${country.name} (+${country.dialCode})',
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 1,
                                                            softWrap: false),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                CircleRadioOption<CountryInfo>(
                                                  onChanged:
                                                      (CountryInfo? value) {
                                                    setState(() {
                                                      selectedCountry = value!;
                                                    });
                                                    _updateSelection(country);
                                                  },
                                                  groupValue: selectedCountry,
                                                  value: filteredElements
                                                          .isNotEmpty
                                                      ? filteredElements[index]
                                                      : countryList[index],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // const SizedBox(
                                          //   height: 4,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F3),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.radius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Text('+${selectedCountry.dialCode}'),
        ),
      ),
    );
  }
}
