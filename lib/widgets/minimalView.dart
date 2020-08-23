import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elements_rework/widgets/localization.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// ignore: camel_case_types
class minimalView extends StatelessWidget {
  @required
  final bool typesOthernonmetals;
  @required
  final bool typesNoblegases;
  @required
  final bool typesAlkalimetals;
  @required
  final bool typesAlkaliearthmetals;
  @required
  final bool typesMetalloids;
  @required
  final bool typesPosttransitionmetals;
  @required
  final bool typesTransitionmetals;
  @required
  final bool typesLanthanoids;
  @required
  final bool typesActinoids;
  @required
  final bool typesUnknown;

  @required
  final double electronnegativityMin;
  @required
  final double electronnegativityMax;
  @required
  final bool electronnegativityUnknown;

  @required
  final int atomicnumberMin;
  @required
  final int atomicnumberMax;

  @required
  final int constructorsProtonMin;
  @required
  final int constructorsProtonMax;

  @required
  final int constructorsElectronMin;
  @required
  final int constructorsElectronMax;

  @required
  final int constructorsNeutronMin;
  @required
  final int constructorsNeutronMax;

  @required
  final double weightMin;
  @required
  final double weightMax;

  @required
  final bool stateElectronnegativity;
  @required
  final bool stateTypes;
  @required
  final bool stateAtomicnumber;
  @required
  final bool stateConstructors;
  @required
  final bool stateWeight;

  const minimalView({
    Key key,
    this.typesOthernonmetals,
    this.typesNoblegases,
    this.typesAlkalimetals,
    this.typesAlkaliearthmetals,
    this.typesMetalloids,
    this.typesPosttransitionmetals,
    this.typesTransitionmetals,
    this.typesLanthanoids,
    this.typesActinoids,
    this.typesUnknown,
    this.electronnegativityMin,
    this.electronnegativityMax,
    this.electronnegativityUnknown,
    this.atomicnumberMin,
    this.atomicnumberMax,
    this.constructorsProtonMin,
    this.constructorsProtonMax,
    this.constructorsElectronMin,
    this.constructorsElectronMax,
    this.constructorsNeutronMin,
    this.constructorsNeutronMax,
    this.weightMin,
    this.weightMax,
    this.stateElectronnegativity,
    this.stateTypes,
    this.stateAtomicnumber,
    this.stateConstructors,
    this.stateWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pass = 0;

    return new FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('lib/elements.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var elementList = json.decode(snapshot.data.toString());
          final listElements = <Widget>[];
          for (var index = 0; index < elementList.length; index++) {
            bool passed = true;

            if (stateElectronnegativity == true) {
              if (electronnegativityUnknown == true &&
                      elementList[index]['electronnegativity'] == 'unknown' ||
                  elementList[index]['electronnegativity'] != 'unknown' &&
                      electronnegativityMin <=
                          num.parse(elementList[index]['electronnegativity']) &&
                      electronnegativityMax >=
                          num.parse(elementList[index]['electronnegativity'])) {
              } else {
                passed = false;
              }
            }

            if (stateTypes == true) {
              if (typesOthernonmetals == true &&
                      elementList[index]['type'] == 'otherNonmetal' ||
                  typesNoblegases == true &&
                      elementList[index]['type'] == 'nobleGas' ||
                  typesAlkalimetals == true &&
                      elementList[index]['type'] == 'alkaliMetal' ||
                  typesAlkaliearthmetals == true &&
                      elementList[index]['type'] == 'alkaliEarthMetal' ||
                  typesMetalloids == true &&
                      elementList[index]['type'] == 'metalloid' ||
                  typesPosttransitionmetals == true &&
                      elementList[index]['type'] == 'post-transitionMetal' ||
                  typesTransitionmetals == true &&
                      elementList[index]['type'] == 'transitionMetal' ||
                  typesLanthanoids == true &&
                      elementList[index]['type'] == 'lanthanoid' ||
                  typesActinoids == true &&
                      elementList[index]['type'] == 'actinoid' ||
                  typesUnknown == true &&
                      elementList[index]['type'] == 'unknown') {
              } else {
                passed = false;
              }
            }

            if (stateAtomicnumber == true) {
              if (atomicnumberMin <= elementList[index]['number'] &&
                  atomicnumberMax >= elementList[index]['number']) {
              } else {
                passed = false;
              }
            }

            if (stateConstructors == true) {
              if (constructorsProtonMin <=
                      int.parse(elementList[index]['chargedComponent']) &&
                  constructorsProtonMax >=
                      int.parse(elementList[index]['chargedComponent']) &&
                  constructorsElectronMin <=
                      int.parse(elementList[index]['chargedComponent']) &&
                  constructorsElectronMax >=
                      int.parse(elementList[index]['chargedComponent']) &&
                  constructorsNeutronMin <=
                      int.parse(elementList[index]['neutron']) &&
                  constructorsNeutronMax >=
                      int.parse(elementList[index]['neutron'])) {
              } else {
                passed = false;
              }
            }

            if (stateWeight == true) {
              if (weightMin <=
                      double.parse(elementList[index]['weight']
                          .replaceAll('(', '')
                          .replaceAll(')', '')) &&
                  weightMax >=
                      double.parse(elementList[index]['weight']
                          .replaceAll('(', '')
                          .replaceAll(')', ''))) {
              } else {
                passed = false;
              }
            }

            if (passed == false) {
            } else {
              pass++;

              String Capitalizate(input) {
                return input[0].toUpperCase() + input.substring(1);
              }

              String isotopeWeight(input) {
                if (input.contains('unknown')) {
                  return Capitalizate(
                      AppLocalizations.of(context).translate('unknown'));
                } else {
                  return input;
                }
              }

              String isotopeRate(input) {
                if (input.contains('unknown')) {
                  return Capitalizate(
                      AppLocalizations.of(context).translate('unknown'));
                } else {
                  return input +
                      AppLocalizations.of(context)
                          .translate('rateSymbolIsotopes');
                }
              }

              String isotopeRadioactivity(input) {
                if (input.contains('unknown')) {
                  return Capitalizate(
                      AppLocalizations.of(context).translate('unknown'));
                } else if (input.contains('stable')) {
                  return Capitalizate(
                      AppLocalizations.of(context).translate('stable'));
                } else {
                  return Capitalizate(
                      AppLocalizations.of(context).translate('radioactive'));
                }
              }

              String toTime(input, inner) {
                if (input.contains('y')) {
                  if (double.parse(input.replaceAll(' y', '')) <= 1) {
                    return input.replaceAll(' y',
                        ' ' + AppLocalizations.of(context).translate('year'));
                  } else {
                    return input.replaceAll(' y',
                        ' ' + AppLocalizations.of(context).translate('years'));
                  }
                } else if (input.contains(' d')) {
                  if (double.parse(input.replaceAll(' d', '')) <= 1) {
                    return input.replaceAll(' d',
                        ' ' + AppLocalizations.of(context).translate('day'));
                  } else {
                    return input.replaceAll(' d',
                        ' ' + AppLocalizations.of(context).translate('days'));
                  }
                } else if (input.contains(' h')) {
                  if (double.parse(input.replaceAll(' h', '')) <= 1) {
                    return input.replaceAll(' h',
                        ' ' + AppLocalizations.of(context).translate('hour'));
                  } else {
                    return input.replaceAll(' h',
                        ' ' + AppLocalizations.of(context).translate('hours'));
                  }
                } else if (input.contains(' min')) {
                  if (double.parse(input.replaceAll(' min', '')) <= 1) {
                    return input.replaceAll(' min',
                        ' ' + AppLocalizations.of(context).translate('minute'));
                  } else {
                    return input.replaceAll(
                        ' min',
                        ' ' +
                            AppLocalizations.of(context).translate('minutes'));
                  }
                } else if (input.contains(' s')) {
                  if (double.parse(input.replaceAll(' s', '')) <= 1) {
                    return input.replaceAll(' s',
                        ' ' + AppLocalizations.of(context).translate('second'));
                  } else {
                    return input.replaceAll(
                        ' s',
                        ' ' +
                            AppLocalizations.of(context).translate('seconds'));
                  }
                } else if (input.contains(' ms')) {
                  if (double.parse(input.replaceAll(' ms', '')) <= 1) {
                    return input.replaceAll(
                        ' ms',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('millisecond'));
                  } else {
                    return input.replaceAll(
                        ' ms',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('milliseconds'));
                  }
                } else if (input.contains(' ns')) {
                  if (double.parse(input.replaceAll(' ns', '')) <= 1) {
                    return input.replaceAll(
                        ' ns',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('nanosecond'));
                  } else {
                    return input.replaceAll(
                        ' ns',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('nanoseconds'));
                  }
                } else if (input.contains(' ps')) {
                  if (double.parse(input.replaceAll(' ps', '')) <= 1) {
                    return input.replaceAll(
                        ' ps',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('picosecond'));
                  } else {
                    return input.replaceAll(
                        ' ps',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('picoseconds'));
                  }
                } else if (input.contains(' µs')) {
                  if (double.parse(input.replaceAll(' µs', '')) <= 1) {
                    return input.replaceAll(
                        ' µs',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('microsecond'));
                  } else {
                    return input.replaceAll(
                        ' µs',
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('microseconds'));
                  }
                } else if (input == 'unknown') {
                  //print(elementList[index]['isotopes'][inner]['en'] + ': UNKNOWN');
                } else if (input == 'stable') {
                  //print(elementList[index]['isotopes'][inner]['en'] + ': STABLE');
                } else if (input == '') {
                  //print(elementList[index]['isotopes'][inner]['en'] + ': NULL');
                } else {
                  print(elementList[index]['isotopes'][inner]['en'] +
                      ': ' +
                      elementList[index]['isotopes'][inner]['halfRate']);
                }
                //print(elementList[index]['isotopes'][inner]['en'] + ': ' + elementList[index]['isotopes'][inner]['halfRate']);
                return input;
              }

              bool isotopeHalflifePointer(input) {
                if (input.contains('unknown')) {
                  return true;
                } else if (input.contains('stable')) {
                  return true;
                } else {
                  return false;
                }
              }

              double isotopeHalflifeVisibility(input) {
                if (input.contains('unknown')) {
                  return 0;
                } else if (input.contains('stable')) {
                  return 0;
                } else {
                  return 1;
                }
              }

              final listIsotopes = <Widget>[];
              listIsotopes.add(Container(
                  width: MediaQuery.of(context).size.width * .15 / 2));
              for (var innerIndex = 0;
                  innerIndex < elementList[index]['isotopes'].length;
                  innerIndex++) {
                listIsotopes.add(
                  new Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .15 / 2,
                        right: MediaQuery.of(context).size.width * .15 / 2),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .7,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(150, 150, 150, .4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            (MediaQuery.of(context).size.height +
                                    MediaQuery.of(context).size.width) /
                                2 *
                                .03,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * .15 / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Tooltip(
                              message: AppLocalizations.of(context)
                                  .translate('isotopeName'),
                              child: AutoSizeText(
                                elementList[index]['isotopes'][innerIndex][
                                    AppLocalizations.of(context)
                                        .translate('key')],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .04,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                              ),
                            ),
                            Tooltip(
                              message: AppLocalizations.of(context)
                                  .translate('isotopeWeight'),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Capitalizate(AppLocalizations.of(context)
                                        .translate('weightIsotopes')),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .03,
                                    ),
                                  ),
                                  AutoSizeText(
                                    isotopeWeight(elementList[index]['isotopes']
                                        [innerIndex]['weight']),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .03,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                              ),
                            ),
                            Tooltip(
                              message: AppLocalizations.of(context)
                                  .translate('rate'),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('rateIsotopes'),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .03,
                                    ),
                                  ),
                                  AutoSizeText(
                                    isotopeRate(elementList[index]['isotopes']
                                        [innerIndex]['rate']),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .03,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * .03,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Tooltip(
                                  message: AppLocalizations.of(context)
                                      .translate('isotopeRadioactivity'),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .01),
                                        child: Image(
                                            image: AssetImage(
                                                "lib/icons/radioactive_white_500.png"),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .04,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .04),
                                      ),
                                      Text(
                                        " " +
                                            isotopeRadioactivity(
                                                elementList[index]['isotopes']
                                                    [innerIndex]['halfRate']),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IgnorePointer(
                                  ignoring: isotopeHalflifePointer(
                                      elementList[index]['isotopes'][innerIndex]
                                          ['halfRate']),
                                  child: Opacity(
                                    opacity: isotopeHalflifeVisibility(
                                        elementList[index]['isotopes']
                                            [innerIndex]['halfRate']),
                                    child: Tooltip(
                                      message: AppLocalizations.of(context)
                                          .translate('isotopeHalflife'),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .01),
                                            child: Image(
                                                image: AssetImage(
                                                    "lib/icons/halftime_white_500.png"),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .045,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .045),
                                          ),
                                          Expanded(
                                              child: AutoSizeText(
                                            ' ' +
                                                toTime(
                                                    elementList[index]
                                                                ['isotopes']
                                                            [innerIndex]
                                                        ['halfRate'],
                                                    innerIndex),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .03,
                                            ),
                                            minFontSize: 1,
                                            maxLines: 1,
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              listIsotopes.add(Container(
                  width: MediaQuery.of(context).size.width * .15 / 2));

              listElements.add(
                GestureDetector(
                  onTap: () {
                    String ElectronnegativityText(input) {
                      if (input == 'unknown') {
                        return Capitalizate(
                            AppLocalizations.of(context).translate('unknown'));
                      } else {
                        return input;
                      }
                    }

                    String consistencyIcon() {
                      if (elementList[index]["consistency"] == "gas") {
                        return "lib/icons/gas_white_500.png";
                      } else if (elementList[index]["consistency"] == "fluid") {
                        return "lib/icons/fluid_white_500.png";
                      } else if (elementList[index]["consistency"] == "solid") {
                        return "lib/icons/solid_white_500.png";
                      } else {
                        return "lib/icons/questionmark_white_500.png";
                      }
                    }

                    String consistencyText() {
                      if (elementList[index]["consistency"] == "gas") {
                        return " " +
                            Capitalizate(
                                AppLocalizations.of(context).translate("gas"));
                      } else if (elementList[index]["consistency"] == "fluid") {
                        return " " +
                            Capitalizate(AppLocalizations.of(context)
                                .translate("fluid"));
                      } else if (elementList[index]["consistency"] == "solid") {
                        return " " +
                            Capitalizate(AppLocalizations.of(context)
                                .translate("solid"));
                      } else {
                        return " " +
                            Capitalizate(AppLocalizations.of(context)
                                .translate("unknown"));
                      }
                    }

                    String discoveryText() {
                      if (elementList[index]["discovery"] == "ancient") {
                        return ' ' +
                            Capitalizate(AppLocalizations.of(context)
                                .translate("ancient"));
                      } else {
                        return ' ' + elementList[index]["discovery"];
                      }
                    }

                    String radioactivityString() {
                      if (elementList[index]["radioactivity"] == "stable") {
                        return " " +
                            Capitalizate(AppLocalizations.of(context)
                                .translate("stable"));
                      } else {
                        String list = " ";
                        if (elementList[index]["gamma"] == true) {
                          list += Capitalizate(AppLocalizations.of(context)
                                  .translate("gamma")) +
                              " ";
                        } else if (elementList[index]["beta"] == true) {
                          list += Capitalizate(AppLocalizations.of(context)
                                  .translate("beta")) +
                              " ";
                        } else if (elementList[index]["alpha"] == true) {
                          list += Capitalizate(AppLocalizations.of(context)
                                  .translate("alpha")) +
                              " ";
                        } else if (elementList[index]
                                ["multipleRadiationEmitters"] ==
                            true) {
                          list += Capitalizate(AppLocalizations.of(context)
                                  .translate("multipleRadiationEmitters") +
                              " ");
                        } else {
                          list = " " +
                              Capitalizate(AppLocalizations.of(context)
                                  .translate("radioactive"));
                        }
                        return list;
                      }
                    }

                    String typeText() {
                      return Capitalizate(AppLocalizations.of(context)
                          .translate(elementList[index]["type"]));
                    }

                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return DraggableScrollableSheet(
                              initialChildSize: .56,
                              maxChildSize: 1,
                              builder:
                                  (BuildContext context, scrollController) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      (MediaQuery.of(context).size.height +
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) /
                                          2 *
                                          .1,
                                    ),
                                    topRight: Radius.circular(
                                        (MediaQuery.of(context).size.height +
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                            2 *
                                            .1),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: (MediaQuery.of(context)
                                                    .size
                                                    .height +
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                            2 *
                                            .05,
                                        sigmaY: (MediaQuery.of(context)
                                                    .size
                                                    .height +
                                                MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                            2 *
                                            .05),
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 30, bottom: 30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate("elementName"),
                                                  child: AutoSizeText(
                                                    elementList[index][
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate("key")],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      height: 1.2,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .1,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  bottom: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height +
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width) /
                                                      2 *
                                                      .05,
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Tooltip(
                                                      message: AppLocalizations
                                                              .of(context)
                                                          .translate("symbol"),
                                                      child: Text(
                                                        elementList[index]
                                                                ["element"] +
                                                            ', ',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (1 /
                                                                  int.parse(AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "maxVolume"))),
                                                        ),
                                                      ),
                                                    ),
                                                    Tooltip(
                                                      message: AppLocalizations
                                                              .of(context)
                                                          .translate(
                                                              "elementNumber"),
                                                      child: Text(
                                                        elementList[index]
                                                                ["number"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (1 /
                                                                  int.parse(AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "maxVolume"))),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate("consistency"),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image(
                                                          image: AssetImage(
                                                              consistencyIcon()),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .07,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .07),
                                                      Text(
                                                        consistencyText(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: Capitalizate(
                                                    AppLocalizations.of(context)
                                                        .translate("discovery"),
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image(
                                                          image: AssetImage(
                                                              "lib/icons/discovery_white_500.png"),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .07,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .07),
                                                      Text(
                                                        discoveryText(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          "radioactivity"),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image(
                                                          image: AssetImage(
                                                              "lib/icons/radioactive_white_500.png"),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .06,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .06),
                                                      Text(
                                                        " " +
                                                            radioactivityString(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .7,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .01,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .05),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'radioactivityInfo'),
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .06,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate("type"),
                                                  child: Text(
                                                    typeText(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  top: (MediaQuery.of(context)
                                                              .size
                                                              .height +
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width) /
                                                      2 *
                                                      .05,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          "electronnegativity"),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                            .translate(
                                                                "electronnegativityPre") +
                                                        ": " +
                                                        ElectronnegativityText(
                                                            elementList[index][
                                                                "electronnegativity"]),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate("block"),
                                                  child: Text(
                                                    Capitalizate(AppLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "blockPre")) +
                                                        ": " +
                                                        Capitalizate(
                                                            elementList[index]
                                                                ["block"]),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate("weight"),
                                                  child: Text(
                                                    Capitalizate(AppLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "weightPre")) +
                                                        ": " +
                                                        Capitalizate(
                                                            elementList[index]
                                                                ["weight"]),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  bottom: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height +
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width) /
                                                      2 *
                                                      .05,
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .6,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .01),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'molarmass'),
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .06,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .01,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate('isotopeTitle')
                                                      .replaceAll(
                                                          '{elementName}',
                                                          elementList[index][
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'key')]),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('isotopes'),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child:
                                                    Row(children: listIsotopes),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height +
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width) /
                                                          2 *
                                                          .05,
                                                    ),
                                                    child: Tooltip(
                                                      message: AppLocalizations
                                                              .of(context)
                                                          .translate(
                                                              'protonnumber'),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'protons') +
                                                            ': ' +
                                                            elementList[index][
                                                                'chargedComponent'],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          'electronnumber'),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                            .translate(
                                                                'electrons') +
                                                        ': ' +
                                                        elementList[index][
                                                            'chargedComponent'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .15,
                                                ),
                                                child: Tooltip(
                                                  message: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          'neutronnumber'),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                            .translate(
                                                                'neutrons') +
                                                        ': ' +
                                                        elementList[index]
                                                            ['neutron'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.height +
                                MediaQuery.of(context).size.width) /
                            2 *
                            .025,
                        right: (MediaQuery.of(context).size.height +
                                MediaQuery.of(context).size.width) /
                            2 *
                            .025,
                        bottom: (MediaQuery.of(context).size.height +
                                MediaQuery.of(context).size.width) /
                            2 *
                            .05),
                    decoration: new BoxDecoration(
                        color: Color(int.parse(elementList[index]["m1"])),
                        borderRadius: BorderRadius.circular(
                            (MediaQuery.of(context).size.height +
                                    MediaQuery.of(context).size.width) /
                                2 *
                                .02)),
                    height: (MediaQuery.of(context).size.height +
                            MediaQuery.of(context).size.width) /
                        2 *
                        .13,
                    width: (MediaQuery.of(context).size.width +
                            MediaQuery.of(context).size.height) /
                        2 *
                        .13,
                    child: new Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Align(
                          alignment: Alignment.center,
                          child: new Text(
                            elementList[index]["element"].toString(),
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: (MediaQuery.of(context).size.height +
                                      MediaQuery.of(context).size.width) /
                                  2 *
                                  .06,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }

          if (pass == 0) {
            return Container(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate('noResTitle'),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * .1),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('noResContent'),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                        fontSize: MediaQuery.of(context).size.width * .06),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(color: Color(0xffffffff)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .02,
                    bottom: MediaQuery.of(context).size.height * .02),
                child: new Tooltip(
                  message: AppLocalizations.of(context)
                      .translate("moreAboutElement"),
                  child: Stack(
                    children: <Widget>[
                      SizedBox.expand(
                        child: Padding(
                          padding: EdgeInsets.only(left: 7, right: 7),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * .04),
                              Column(
                                children: <Widget>[
                                  new Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 0,
                                    runSpacing: 0,
                                    children: listElements,
                                  ),
                                ],
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * .01),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -1,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .05,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 1.0],
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -1,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .07,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 1.0],
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return SleekCircularSlider(
          appearance: CircularSliderAppearance(
            spinnerMode: true,
            size: (MediaQuery.of(context).size.height +
                    MediaQuery.of(context).size.width) /
                2 *
                .4,
            customColors: CustomSliderColors(
              trackColor: Color(0x00000000),
              hideShadow: true,
              progressBarColors: <Color>[
                Color(0xff62a39c),
                Color(0xff13547a),
              ],
            ),
          ),
        );
      },
    );
  }
}
