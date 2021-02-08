import 'package:flutter/material.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String> tags;
  final Function getCurrentPage;
  final bool isOnSearch;
  final TextEditingController searchController;
  final Function searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  Navbar(
      {this.title = "Home",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
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
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags.length == 0 ? false : true);

    return Container(
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent
                                    ? (widget.bgColor == CommonColors.white
                                        ? CommonColors.initial
                                        : CommonColors.white)
                                    : CommonColors.white,
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton)
                                Scaffold.of(context).openDrawer();
                              else
                                Navigator.pop(context);
                            }),
                        Text(widget.title,
                            style: TextStyle(
                                color: !widget.transparent
                                    ? (widget.bgColor == CommonColors.white
                                        ? CommonColors.initial
                                        : CommonColors.white)
                                    : CommonColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.0)),
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
