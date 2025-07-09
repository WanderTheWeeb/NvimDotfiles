return {
  -- Flutter Tools
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          -- Use IGOR colors for Flutter UI
          border = "rounded",
          notification_style = "plugin",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
            project_config = true,
          },
        },
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "IgorClosingTag",
          prefix = "// ",
          enabled = true,
        },
        dev_log = {
          enabled = true,
          notify_errors = true,
          open_cmd = "tabedit",
        },
        lsp = {
          color = {
            enabled = true,
            background = false,
            background_color = nil,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
          },
          capabilities = function(config)
            config.textDocument.completion.completionItem.snippetSupport = true
            return config
          end,
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = { vim.fn.expand("$HOME/.pub-cache") },
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      })

      -- Custom highlight groups for Flutter
      vim.api.nvim_set_hl(0, "IgorClosingTag", {
        fg = "#ff69b4",
        italic = true,
        bold = false,
      })

      -- Dart/Flutter specific keymaps
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>fs", ":FlutterRun<CR>", opts)
      vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>", opts)
      vim.keymap.set("n", "<leader>fr", ":FlutterReload<CR>", opts)
      vim.keymap.set("n", "<leader>fR", ":FlutterRestart<CR>", opts)
      vim.keymap.set("n", "<leader>fd", ":FlutterDevices<CR>", opts)
      vim.keymap.set("n", "<leader>fo", ":FlutterOutlineToggle<CR>", opts)
      vim.keymap.set("n", "<leader>ft", ":FlutterLspRestart<CR>", opts)
      vim.keymap.set("n", "<leader>fD", ":FlutterVisualDebug<CR>", opts)
    end,
  },

  -- Dart syntax improvements
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
    config = function()
      vim.g.dart_style_guide = 1
      vim.g.dart_format_on_save = 1

      -- IGOR theme specific Dart highlighting
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dart",
        callback = function()
          -- Widget names in Flutter
          vim.api.nvim_set_hl(0, "DartWidget", {
            fg = "#ff69b4",
            bold = true,
          })

          -- Flutter imports
          vim.api.nvim_set_hl(0, "DartFlutterImport", {
            fg = "#02569b",
            italic = true,
          })

          -- Dart keywords
          vim.api.nvim_set_hl(0, "DartKeyword", {
            fg = "#9370db",
            italic = true,
          })

          -- Dart types
          vim.api.nvim_set_hl(0, "DartType", {
            fg = "#0175c2",
            bold = false,
          })

          -- Dart strings
          vim.api.nvim_set_hl(0, "DartString", {
            fg = "#00ff7f",
          })

          -- Dart numbers
          vim.api.nvim_set_hl(0, "DartNumber", {
            fg = "#ffd700",
          })

          -- Dart comments
          vim.api.nvim_set_hl(0, "DartComment", {
            fg = "#6d6d6d",
            italic = true,
          })

          -- Function definitions
          vim.api.nvim_set_hl(0, "DartFunction", {
            fg = "#ff69b4",
            bold = true,
          })

          -- Match syntax groups
          vim.cmd([[
            syntax match DartWidget /\<\u\w*\>/ contained containedin=dartIdentifier
            syntax match DartFlutterImport /import\s\+['"]package:flutter.*['"]/ contains=dartString
            syntax match DartKeyword /\<\(widget\|build\|setState\|initState\|dispose\|didChangeDependencies\|didUpdateWidget\)\>/
            syntax match DartType /\<\(Widget\|StatelessWidget\|StatefulWidget\|State\|BuildContext\|Key\|EdgeInsets\|Color\|TextStyle\|MainAxisAlignment\|CrossAxisAlignment\|Axis\|BoxDecoration\|BorderRadius\|BoxShadow\|Gradient\|LinearGradient\|RadialGradient\|Animation\|AnimationController\|Tween\|Curve\|Duration\|ThemeData\|MaterialApp\|Scaffold\|AppBar\|FloatingActionButton\|BottomNavigationBar\|Drawer\|ListView\|GridView\|Column\|Row\|Container\|Padding\|Margin\|Center\|Align\|Expanded\|Flexible\|Positioned\|Stack\|IndexedStack\|PageView\|TabBar\|TabBarView\|TextField\|TextFormField\|Form\|FormField\|Button\|ElevatedButton\|OutlinedButton\|TextButton\|IconButton\|GestureDetector\|InkWell\|Hero\|AnimatedContainer\|AnimatedOpacity\|FadeTransition\|SlideTransition\|ScaleTransition\|RotationTransition\|FutureBuilder\|StreamBuilder\|ValueListenableBuilder\|Consumer\|Provider\|ChangeNotifier\|ValueNotifier\|Listenable\|ChangeNotifierProvider\|StreamProvider\|FutureProvider\|MultiProvider\|Selector\|Navigator\|Route\|PageRoute\|MaterialPageRoute\|PageRouteBuilder\|ModalRoute\|PopupRoute\|Dialog\|AlertDialog\|SimpleDialog\|BottomSheet\|SnackBar\|Toast\|Tooltip\|PopupMenuButton\|DropdownButton\|Slider\|Switch\|Checkbox\|Radio\|ProgressIndicator\|CircularProgressIndicator\|LinearProgressIndicator\|RefreshIndicator\|SingleChildScrollView\|CustomScrollView\|SliverAppBar\|SliverList\|SliverGrid\|SliverToBoxAdapter\|SliverFillRemaining\|SliverPadding\|NestedScrollView\|NotificationListener\|ScrollController\|ScrollPhysics\|BouncingScrollPhysics\|ClampingScrollPhysics\|NeverScrollableScrollPhysics\|AlwaysScrollableScrollPhysics\|FixedExtentScrollPhysics\|PageScrollPhysics\|RangeMaintainingScrollPhysics\|ScrollBehavior\|ScrollConfiguration\|Scrollable\|Scrollbar\|CupertinoScrollbar\|MediaQuery\|MediaQueryData\|Orientation\|TargetPlatform\|Theme\|ThemeData\|CupertinoTheme\|CupertinoThemeData\|MaterialLocalizations\|CupertinoLocalizations\|Localizations\|Locale\|LocalizationsDelegate\|GlobalMaterialLocalizations\|GlobalCupertinoLocalizations\|GlobalWidgetsLocalizations\|WidgetsApp\|CupertinoApp\|MaterialApp\|Directionality\|TextDirection\|LayoutBuilder\|OrientationBuilder\|FractionallySizedBox\|AspectRatio\|ConstrainedBox\|UnconstrainedBox\|OverflowBox\|SizedBox\|LimitedBox\|IntrinsicHeight\|IntrinsicWidth\|Transform\|RotatedBox\|ClipRect\|ClipRRect\|ClipOval\|ClipPath\|CustomClipper\|CustomPainter\|CustomPaint\|RepaintBoundary\|IgnorePointer\|AbsorbPointer\|Opacity\|ShaderMask\|BackdropFilter\|ImageFilter\|ColorFilter\|ColorFiltered\|FittedBox\|BoxFit\|Alignment\|AlignmentGeometry\|AlignmentDirectional\|FractionalOffset\|FractionalOffsetGeometry\|Decoration\|BoxDecoration\|ShapeDecoration\|FlutterLogoDecoration\|UnderlineTabIndicator\|Border\|BorderSide\|BorderRadius\|BorderDirectional\|ShapeBorder\|RoundedRectangleBorder\|CircleBorder\|BeveledRectangleBorder\|StadiumBorder\|ContinuousRectangleBorder\|OutlinedBorder\|InputBorder\|UnderlineInputBorder\|OutlineInputBorder\|InputDecoration\|InputDecorationTheme\|TextInputType\|TextInputAction\|TextInputFormatter\|TextEditingController\|TextSelectionControls\|TextSelection\|TextSpan\|TextStyle\|FontWeight\|FontStyle\|TextDecoration\|TextDecorationStyle\|TextAlign\|TextBaseline\|TextWidthBasis\|TextHeightBehavior\|TextLeadingDistribution\|StrutStyle\|ParagraphStyle\|TextPainter\|TextLayoutMetrics\|Image\|ImageProvider\|AssetImage\|NetworkImage\|FileImage\|MemoryImage\|ExactAssetImage\|ResizeImage\|ImageStream\|ImageStreamCompleter\|ImageConfiguration\|ImageInfo\|ImageChunkEvent\|DecorationImage\|ImageRepeat\|ImageErrorListener\|ImageLoadingBuilder\|ImageFrameBuilder\|FilterQuality\|Icon\|IconData\|IconTheme\|IconThemeData\|Icons\|CupertinoIcons\|Colors\|MaterialColor\|MaterialAccentColor\|ColorSwatch\|HSVColor\|HSLColor\|Paint\|PaintingStyle\|BlendMode\|StrokeCap\|StrokeJoin\|TileMode\|FilterQuality\|Canvas\|Path\|PathOperation\|PathFillType\|Rect\|RRect\|Offset\|Size\|Radius\|EdgeInsets\|EdgeInsetsGeometry\|EdgeInsetsDirectional\|TextInputType\|Brightness\|SystemUiOverlayStyle\|DeviceOrientation\|SystemChrome\|SystemSound\|SystemSoundType\|HapticFeedback\|ServicesBinding\|WidgetsBinding\|SchedulerBinding\|GestureBinding\|RendererBinding\|SemanticsBinding\|PaintingBinding\|ServicesBinding\|WidgetsFlutterBinding\|runApp\|debugPrint\|debugPrintGestureArenaDiagnostics\|debugPrintHitTestResults\|debugPrintLayerTree\|debugPrintRenderTree\|debugPrintScheduleFrameStacks\|debugPrintStack\|debugPrintThrottledUserGestures\|debugProfileBuildsEnabled\|debugProfileLayoutsEnabled\|debugProfilePaintsEnabled\|debugRepaintRainbowEnabled\|debugRepaintTextRainbowEnabled\|kDebugMode\|kProfileMode\|kReleaseMode\|kIsWeb\|defaultTargetPlatform\|TargetPlatform\|Key\|LocalKey\|ValueKey\|ObjectKey\|UniqueKey\|GlobalKey\|GlobalObjectKey\|LabeledGlobalKey\)\>/
          ]])
        end,
      })
    end,
  },
}
