return {
  "akinsho/bufferline.nvim",
  opts = function(_, opts)
    opts.highlights = vim.tbl_deep_extend("force", opts.highlights or {}, {
      fill = { bg = "none" },
      background = { bg = "none" },
      buffer_selected = { bg = "none" },
    })
  end,
}
