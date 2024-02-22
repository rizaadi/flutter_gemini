import 'package:flutter/material.dart';
import 'package:flutter_gemini/presentation/text_and_image/pages/text_and_image_page.dart';
import 'package:flutter_gemini/presentation/text_only/pages/text_only_pages.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: TabBar(
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Text only'),
            Tab(text: 'Text and Image'),
            Tab(text: 'Chat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TextOnlyPage(),
          TextAndImagePage(),
          Center(child: Text('Chat')),
        ],
      ),
    );
  }
}
