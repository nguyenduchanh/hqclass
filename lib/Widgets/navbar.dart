import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:hqclass/Util/Constants/navigator_helper.dart';
import 'package:hqclass/Util/Constants/strings.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final bool deleteOption;
  final List<String> tags;
  final Function getCurrentPage;
  final bool isOnSearch;
  final TextEditingController searchController;
  final Function searchOnChanged;
  final Function checkButtonClick;

  final bool searchAutofocus;
  final bool noShadow;
  final bool checkButtonOption;
  final Color bgColor;

  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.deleteOption = false,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.checkButtonClick,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.checkButtonOption = false,
      this.bgColor = CommonColors.kPrimaryColor,
      this.searchBar = false});

  final double _prefferedHeight = 50.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  String activeTag;

  ItemScrollController _scrollController = ItemScrollController();

  void initState() {
    if (widget.tags != null && widget.tags.length != 0) {
      activeTag = widget.tags[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags.length == 0 ? false : true);

    return Container(
        decoration: BoxDecoration(
          color: !widget.transparent ? widget.bgColor : Colors.transparent,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton
                                    ? Icons.menu
                                    : Icons.arrow_back,
                                color: !widget.transparent
                                    ? (widget.bgColor == CommonColors.white
                                        ? CommonColors.initial
                                        : CommonColors.white)
                                    : CommonColors.white,
                                size: 25.0),
                            onPressed: () {
                              if (!widget.backButton)
                                Scaffold.of(context).openDrawer();
                              else{
                                if(widget.title == CommonString.cRegisterTitle){
                                  NavigatorHelper().toLoginPage(context);
                                }else{
                                  Navigator.pop(context);
                                }
                              }
                                // Navigator.of(context).maybePop();
                                // NavigatorHelper().toLoginPage(context);
                                // Navigator.pop(context);
                            }),
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == CommonColors.white
                                        ? CommonColors.initial
                                        : CommonColors.white)
                                    : CommonColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
