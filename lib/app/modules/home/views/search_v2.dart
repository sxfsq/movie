import 'package:flutter/material.dart';

class SearchV2 extends StatefulWidget {
  const SearchV2({super.key});

  @override
  State<SearchV2> createState() => _SearchV2State();
}

class _SearchV2State extends State<SearchV2> {
  // 亮/暗色模式flag
  bool isDarkMode = false;
  final List<String> hotSearches = [
    '恶意',
    '无名之辈：吾极索来',
    '国家宝藏',
    '梅根2.0',
    '她的罪床生涯',
    '疾速追杀：苔菉索姬',
    '复活她',
    '胖尼计划',
    '水饺皇后',
    '人生开门红',
  ];

  // Mock 资源列表数据
  final List<Map<String, dynamic>> resources = [
    {'id': 1, 'name': '电影', 'icon': Icons.local_movies, 'count': 156},
    {'id': 2, 'name': '电视剧', 'icon': Icons.desktop_windows, 'count': 89},
    {'id': 3, 'name': '综艺', 'icon': Icons.tv, 'count': 45},
    {'id': 4, 'name': '动漫', 'icon': Icons.all_inclusive, 'count': 67},
    {'id': 5, 'name': '纪录片', 'icon': Icons.ondemand_video, 'count': 23},
  ];

  // Mock 资源源列表（左侧 sidebar）
  final List<Map<String, dynamic>> sourceList = [
    {'id': 1, 'name': '木耳资源'},
    {'id': 2, 'name': '如意资源'},
    {'id': 3, 'name': '魔抓资源'},
    {'id': 4, 'name': '量子资源'},
    {'id': 5, 'name': '极速资源'},
    {'id': 6, 'name': '无尽资源'},
    {'id': 7, 'name': '卧龙资源'},
    {'id': 8, 'name': '豆瓣资源'},
    {'id': 9, 'name': '无忧资源'},
    {'id': 10, 'name': '阿里资源'},
  ];

  // Mock 每个资源源下的内容卡片数据（右侧内容区）
  final Map<int, List<Map<String, dynamic>>> sourceContent = {
    1: [
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索',
        'tags': ['木耳资源'],
      },
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索',
        'tags': ['木耳资源'],
      },
      {
        'cover': 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2628469346.jpg',
        'title': '请输入搜索词：WWW',
        'tags': ['木耳资源'],
      },
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索',
        'tags': ['木耳资源'],
      },
      {
        'cover': 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2882252822.jpg',
        'title': '搜索者1956',
        'tags': ['英语,纳瓦霍语,西班牙', '如意资源'],
      },
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索[电影解说]',
        'tags': ['汉语普通话', '如意资源'],
      },
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索并推毁[电影解说]',
        'tags': ['英语', '如意资源'],
      },
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索并推毁',
        'tags': ['英语', '如意资源'],
      },
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索2020',
        'tags': ['韩语', '如意资源'],
      },
    ],
    2: [
      {
        'cover': 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2882252822.jpg',
        'title': '搜索者1956',
        'tags': ['英语,纳瓦霍语,西班牙', '如意资源'],
      },
      {
        'cover': 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2629056068.jpg',
        'title': '搜索[电影解说]',
        'tags': ['汉语普通话', '如意资源'],
      },
    ],
    // 其他资源源 mock 数据可自行补充
  };

  int selectedSourceId = 1;

  // 搜索源多选状态
  late List<int> selectedSourceIds;

  @override
  void initState() {
    super.initState();
    selectedSourceIds = sourceList.map((e) => e['id'] as int).toList();
  }

  void _showSourceSelectModal() async {
    final allIds = sourceList.map((e) => e['id'] as int).toList();
    final result = await showModalBottomSheet<List<int>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        List<int> tempSelected = List<int>.from(selectedSourceIds);
        bool isAllSelected = tempSelected.length == allIds.length;
        final modalBg = isDarkMode ? const Color(0xFF232226) : Colors.white;
        final modalTitleColor = isDarkMode ? Colors.white : const Color(0xFF222222);
        final modalSubColor = isDarkMode ? const Color(0xFFB0B3B8) : const Color(0xFFB0B3B8);
        final modalActiveColor = isDarkMode ? const Color(0xFF3B6EFF) : const Color(0xFF3B6EFF);
        final modalCheckColor = isDarkMode ? Colors.white : Colors.white;
        final modalUnselectedColor = isDarkMode ? Colors.white24 : Colors.black26;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: modalBg,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text('取消', style: TextStyle(fontSize: 16, color: modalSubColor)),
                        ),
                        const Spacer(),
                        Text('选择搜索源', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: modalTitleColor)),
                        const Spacer(),
                        Text('共${allIds.length}条', style: TextStyle(fontSize: 15, color: modalSubColor)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // 多选项
                    Wrap(
                      spacing: 0,
                      runSpacing: 0,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 32,
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 4.5,
                            children: [
                              // 全选/全不选
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: modalUnselectedColor,
                                  checkboxTheme: CheckboxThemeData(
                                    fillColor: WidgetStateProperty.resolveWith((states) => modalActiveColor),
                                    checkColor: WidgetStateProperty.resolveWith((states) => modalCheckColor),
                                  ),
                                ),
                                child: CheckboxListTile(
                                  value: isAllSelected,
                                  onChanged: (v) {
                                    setModalState(() {
                                      if (v == true) {
                                        tempSelected = List<int>.from(allIds);
                                      } else {
                                        tempSelected.clear();
                                      }
                                    });
                                  },
                                  title: Text('取消全选', style: TextStyle(fontSize: 16, color: modalTitleColor)),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: modalActiveColor,
                                ),
                              ),
                              ...sourceList.map((e) {
                                final id = e['id'] as int;
                                final checked = tempSelected.contains(id);
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: modalUnselectedColor,
                                    checkboxTheme: CheckboxThemeData(
                                      fillColor: WidgetStateProperty.resolveWith((states) => modalActiveColor),
                                      checkColor: WidgetStateProperty.resolveWith((states) => modalCheckColor),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    value: checked,
                                    onChanged: (v) {
                                      setModalState(() {
                                        if (v == true) {
                                          tempSelected.add(id);
                                        } else {
                                          tempSelected.remove(id);
                                        }
                                      });
                                    },
                                    title: Text(
                                      e['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: checked ? modalTitleColor : modalSubColor,
                                      ),
                                    ),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    activeColor: modalActiveColor,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedSourceIds = result;
        // 若当前选中的资源源被取消，则切换到第一个选中的
        if (!selectedSourceIds.contains(selectedSourceId) && selectedSourceIds.isNotEmpty) {
          selectedSourceId = selectedSourceIds.first;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232226),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: const SizedBox.shrink(),
      ),
      body: _buildSearchMode(),
    );
  }

  Widget _buildHotSearchMode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '热门搜索',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: hotSearches.length,
              itemBuilder: (context, index) {
                final rank = index + 1;
                Color rankColor;
                if (rank == 1) {
                  rankColor = const Color(0xFF4F8CFF);
                } else if (rank == 2) {
                  rankColor = const Color(0xFF5CA6FF);
                } else if (rank == 3) {
                  rankColor = const Color(0xFF6DC1FF);
                } else {
                  rankColor = Colors.white70;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 28,
                        child: Text(
                          '$rank',
                          style: TextStyle(
                            color: rankColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          hotSearches[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchMode() {
    // 颜色定义
    final bgColor = isDarkMode ? const Color(0xFF232226) : const Color(0xFFF7F8FA);
    final sidebarColor = isDarkMode ? const Color(0xFF191A1D) : const Color(0xFFF1F2F6);
    final sidebarSelectedColor = isDarkMode ? const Color(0xFF232226) : Colors.white;
    final sidebarTextColor = isDarkMode ? const Color(0xFFBFC2C8) : const Color(0xFF222222);
    final sidebarSelectedTextColor = isDarkMode ? Colors.white : const Color(0xFF3B6EFF);
    final sidebarBorderRadius = BorderRadius.circular(12);
    final cardColor = isDarkMode ? const Color(0xFF191A1D) : Colors.white;
    final cardTitleColor = isDarkMode ? Colors.white : const Color(0xFF222222);
    final cardSubColor = isDarkMode ? const Color(0xFFBFC2C8) : const Color(0xFFB0B3B8);
    final searchBarBg = isDarkMode ? const Color(0xFF232226) : Colors.white;
    final searchBarTextColor = isDarkMode ? Colors.white70 : const Color(0xFFB0B3B8);
    final searchBarBorder = isDarkMode ? null : Border.all(color: const Color(0xFFE5E6EB));
    final filterIconColor = isDarkMode ? Colors.white70 : const Color(0xFF3B6EFF);
    final tagBg = isDarkMode ? const Color(0xFF4F46E5) : const Color(0xFFE5E6EB);
    final tagTextColor = isDarkMode ? Colors.white : const Color(0xFF3B6EFF);

    return Container(
      color: bgColor,
      child: Row(
        children: [
          // 左侧 sidebar
          Container(
            width: 110,
            color: sidebarColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                // 返回按钮+切换亮/暗色按钮
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: filterIconColor, size: 22),
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: '返回',
                      ),
                      IconButton(
                        icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode, color: filterIconColor),
                        onPressed: () => setState(() => isDarkMode = !isDarkMode),
                        tooltip: '切换主题',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sourceList.length,
                    itemBuilder: (context, index) {
                      final source = sourceList[index];
                      final isSelected = source['id'] == selectedSourceId;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        child: Material(
                          color: isSelected ? sidebarSelectedColor : sidebarColor,
                          borderRadius: sidebarBorderRadius,
                          child: InkWell(
                            borderRadius: sidebarBorderRadius,
                            onTap: () => setState(() => selectedSourceId = source['id']),
                            child: Container(
                              height: 44,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                source['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isSelected ? sidebarSelectedTextColor : sidebarTextColor,
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // 右侧内容区
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                children: [
                  // 搜索栏
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _showSourceSelectModal,
                        child: Icon(Icons.filter_alt_outlined, color: filterIconColor, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: searchBarBg,
                            borderRadius: BorderRadius.circular(22),
                            border: searchBarBorder,
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Icon(Icons.search, color: searchBarTextColor, size: 22),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: '你好',
                                    hintStyle: TextStyle(color: searchBarTextColor, fontSize: 16),
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                  ),
                                ),
                              ),
                              Icon(Icons.close, color: searchBarTextColor, size: 22),
                              const SizedBox(width: 8),
                              Text('取消', style: TextStyle(color: searchBarTextColor, fontSize: 16)),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 内容卡片区
                  ...List.generate(
                    sourceContent[selectedSourceId]?.length ?? 0,
                    (index) {
                      final item = sourceContent[selectedSourceId]![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 封面
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['cover'],
                                width: 80,
                                height: 104,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 80,
                                  height: 104,
                                  color: bgColor,
                                  child: Icon(Icons.broken_image, color: cardSubColor, size: 32),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // 右侧卡片内容
                            Expanded(
                              child: Container(
                                height: 104,
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: TextStyle(
                                        color: cardTitleColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    if (item['subtitle'] != null)
                                      Text(
                                        item['subtitle'],
                                        style: TextStyle(
                                          color: cardSubColor,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    if (item['subtitle'] != null) const SizedBox(height: 4),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: [
                                        for (final tag in item['tags'] as List<String>)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: tagBg,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              tag,
                                              style: TextStyle(
                                                color: tagTextColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
