return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- Habilitamos transparencia
      dimInactive = false,
      terminalColors = true,
      colors = {
        palette = {
          -- IGOR Color Palette (solo para texto)
          -- Fondos transparentes/neutros
          sumiInk0 = "NONE", -- Fondo principal transparente
          sumiInk1 = "NONE", -- Fondo secundario transparente
          sumiInk2 = "NONE", -- Fondo terciario transparente
          sumiInk3 = "#2d2d2d", -- Solo para selecciones mínimas
          sumiInk4 = "#3d3d3d", -- Bordes sutiles
          sumiInk5 = "#4d4d4d", -- Líneas de números
          sumiInk6 = "#6d6d6d", -- Comentarios

          -- IGOR signature colors (solo para texto)
          oldWhite = "#f5f5f5", -- Texto principal
          fujiWhite = "#e8e8e8", -- Texto secundario

          -- IGOR Pink/Rose tones (acentos principales)
          sakuraPink = "#ff69b4", -- Hot pink (acento principal)
          waveRed = "#ff1493", -- Deep pink
          peachRed = "#ff6b9d", -- Light pink

          -- IGOR Orange/Yellow tones
          surimiOrange = "#ff8c00", -- Orange
          roninYellow = "#ffd700", -- Gold yellow
          carpYellow = "#ffff4d", -- Bright yellow

          -- IGOR Green tones (para strings)
          springGreen = "#00ff7f", -- Bright green
          waveAqua1 = "#7fffd4", -- Aqua green
          waveAqua2 = "#66ffcc", -- Light aqua

          -- IGOR Purple/Blue tones
          oniViolet = "#9370db", -- Purple
          crystalBlue = "#87ceeb", -- Light blue
          springBlue = "#4169e1", -- Royal blue

          -- Dart/Flutter specific colors
          dartBlue = "#0175c2", -- Dart blue
          flutterBlue = "#02569b", -- Flutter blue
        },
        theme = {
          wave = {
            ui = {
              -- Todos los fondos transparentes
              bg = "NONE",
              bg_p1 = "NONE",
              bg_p2 = "NONE",
              bg_gutter = "NONE",
              bg_m1 = "NONE",
              bg_m2 = "NONE",
              bg_m3 = "NONE",

              fg = "#f5f5f5",
              fg_dim = "#e8e8e8",
              fg_reverse = "#1a1a1a",

              -- Acentos mínimos
              special = "#ff69b4",
              nontext = "#4d4d4d",
              whitespace = "#3d3d3d",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        local palette = colors.palette

        return {
          -- General syntax highlighting (solo colores de texto)
          Normal = { fg = palette.oldWhite, bg = "NONE" },
          Comment = { fg = palette.sumiInk6, italic = true },
          Constant = { fg = palette.carpYellow },
          String = { fg = palette.springGreen },
          Character = { fg = palette.springGreen },
          Number = { fg = palette.roninYellow },
          Boolean = { fg = palette.roninYellow },
          Float = { fg = palette.roninYellow },

          Identifier = { fg = palette.oldWhite },
          Function = { fg = palette.sakuraPink, bold = true },
          Statement = { fg = palette.waveRed, bold = true },
          Conditional = { fg = palette.waveRed, bold = true },
          Repeat = { fg = palette.waveRed, bold = true },
          Label = { fg = palette.waveRed },
          Operator = { fg = palette.surimiOrange },
          Keyword = { fg = palette.oniViolet, italic = true },
          Exception = { fg = palette.waveRed },

          PreProc = { fg = palette.oniViolet },
          Include = { fg = palette.oniViolet },
          Define = { fg = palette.oniViolet },
          Macro = { fg = palette.oniViolet },
          PreCondit = { fg = palette.oniViolet },

          Type = { fg = palette.crystalBlue },
          StorageClass = { fg = palette.crystalBlue },
          Structure = { fg = palette.crystalBlue },
          Typedef = { fg = palette.crystalBlue },

          Special = { fg = palette.sakuraPink },
          SpecialChar = { fg = palette.sakuraPink },
          Tag = { fg = palette.sakuraPink },
          Delimiter = { fg = palette.oldWhite },
          SpecialComment = { fg = palette.sumiInk6 },
          Debug = { fg = palette.waveRed },

          -- Dart specific highlighting (solo texto)
          ["@keyword.dart"] = { fg = palette.oniViolet, italic = true },
          ["@type.dart"] = { fg = palette.dartBlue },
          ["@type.builtin.dart"] = { fg = palette.dartBlue, bold = true },
          ["@constructor.dart"] = { fg = palette.crystalBlue },
          ["@function.dart"] = { fg = palette.sakuraPink },
          ["@function.method.dart"] = { fg = palette.sakuraPink },
          ["@variable.dart"] = { fg = palette.oldWhite },
          ["@constant.dart"] = { fg = palette.carpYellow },
          ["@string.dart"] = { fg = palette.springGreen },
          ["@comment.dart"] = { fg = palette.sumiInk6, italic = true },
          ["@annotation.dart"] = { fg = palette.surimiOrange },

          -- Flutter specific highlighting (solo texto)
          ["@type.flutter"] = { fg = palette.flutterBlue },
          ["@function.flutter"] = { fg = palette.sakuraPink },
          ["@variable.flutter"] = { fg = palette.oldWhite },

          -- UI minimalista (fondos transparentes)
          LineNr = { fg = palette.sumiInk5, bg = "NONE" },
          CursorLineNr = { fg = palette.sakuraPink, bold = true, bg = "NONE" },
          CursorLine = { bg = "NONE" }, -- Sin fondo
          ColorColumn = { bg = "NONE" }, -- Sin fondo

          -- Search y selection mínimos
          Search = { fg = palette.sumiInk0, bg = palette.surimiOrange },
          IncSearch = { fg = palette.sumiInk0, bg = palette.sakuraPink },
          Visual = { bg = palette.sumiInk3 }, -- Mínimo fondo para selección

          -- Statusline transparente
          StatusLine = { bg = "NONE", fg = palette.oldWhite },
          StatusLineNC = { bg = "NONE", fg = palette.sumiInk5 },

          -- Tabs transparentes
          TabLine = { bg = "NONE", fg = palette.sumiInk5 },
          TabLineFill = { bg = "NONE" },
          TabLineSel = { bg = "NONE", fg = palette.sakuraPink },

          -- Popup menus mínimos
          Pmenu = { bg = palette.sumiInk3, fg = palette.oldWhite },
          PmenuSel = { bg = palette.sakuraPink, fg = palette.sumiInk0 },
          PmenuSbar = { bg = palette.sumiInk4 },
          PmenuThumb = { bg = palette.sakuraPink },

          -- Diagnostics (solo texto)
          DiagnosticError = { fg = palette.waveRed },
          DiagnosticWarn = { fg = palette.surimiOrange },
          DiagnosticInfo = { fg = palette.crystalBlue },
          DiagnosticHint = { fg = palette.waveAqua1 },

          -- Git signs (solo texto)
          GitSignsAdd = { fg = palette.springGreen },
          GitSignsChange = { fg = palette.surimiOrange },
          GitSignsDelete = { fg = palette.waveRed },

          -- Telescope transparente
          TelescopeNormal = { bg = "NONE" },
          TelescopeBorder = { bg = "NONE", fg = palette.sakuraPink },
          TelescopePromptNormal = { bg = "NONE" },
          TelescopePromptBorder = { bg = "NONE", fg = palette.sakuraPink },
          TelescopePromptTitle = { bg = "NONE", fg = palette.sakuraPink },
          TelescopePreviewTitle = { bg = "NONE", fg = palette.springGreen },
          TelescopeResultsTitle = { bg = "NONE", fg = palette.surimiOrange },
          TelescopeSelection = { bg = palette.sumiInk3, fg = palette.sakuraPink },
          TelescopeSelectionCaret = { fg = palette.sakuraPink },

          -- Which-key transparente
          WhichKey = { fg = palette.sakuraPink },
          WhichKeyDesc = { fg = palette.oldWhite },
          WhichKeyGroup = { fg = palette.oniViolet },
          WhichKeySeperator = { fg = palette.sumiInk5 },

          -- Nvim-tree transparente
          NvimTreeNormal = { bg = "NONE" },
          NvimTreeFolderIcon = { fg = palette.sakuraPink },
          NvimTreeFolderName = { fg = palette.crystalBlue },
          NvimTreeOpenedFolderName = { fg = palette.crystalBlue, bold = true },
          NvimTreeFileName = { fg = palette.oldWhite },
          NvimTreeFileIcon = { fg = palette.surimiOrange },
          NvimTreeSpecialFile = { fg = palette.sakuraPink },
          NvimTreeGitDirty = { fg = palette.surimiOrange },
          NvimTreeGitStaged = { fg = palette.springGreen },
          NvimTreeGitMerge = { fg = palette.waveRed },
          NvimTreeGitRenamed = { fg = palette.oniViolet },
          NvimTreeGitNew = { fg = palette.springGreen },
          NvimTreeGitDeleted = { fg = palette.waveRed },

          -- Lualine minimalista
          lualine_a_normal = { bg = "NONE", fg = palette.sakuraPink, bold = true },
          lualine_a_insert = { bg = "NONE", fg = palette.springGreen, bold = true },
          lualine_a_visual = { bg = "NONE", fg = palette.surimiOrange, bold = true },
          lualine_a_replace = { bg = "NONE", fg = palette.waveRed, bold = true },
          lualine_a_command = { bg = "NONE", fg = palette.oniViolet, bold = true },

          -- Bufferline transparente
          BufferLineIndicatorSelected = { fg = palette.sakuraPink },
          BufferLineFill = { bg = "NONE" },
          BufferLineBackground = { bg = "NONE", fg = palette.sumiInk5 },
          BufferLineBufferSelected = { bg = "NONE", fg = palette.sakuraPink, bold = true },
          BufferLineBufferVisible = { bg = "NONE", fg = palette.oldWhite },
          BufferLineCloseButton = { bg = "NONE", fg = palette.sumiInk5 },
          BufferLineCloseButtonSelected = { bg = "NONE", fg = palette.waveRed },
          BufferLineCloseButtonVisible = { bg = "NONE", fg = palette.sumiInk5 },

          -- Elementos adicionales transparentes
          SignColumn = { bg = "NONE" },
          FoldColumn = { bg = "NONE", fg = palette.sumiInk5 },
          VertSplit = { fg = palette.sumiInk4, bg = "NONE" },
          WinSeparator = { fg = palette.sumiInk4, bg = "NONE" },
          EndOfBuffer = { fg = palette.sumiInk4, bg = "NONE" },

          -- Floating windows transparentes
          NormalFloat = { bg = "NONE", fg = palette.oldWhite },
          FloatBorder = { bg = "NONE", fg = palette.sakuraPink },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
