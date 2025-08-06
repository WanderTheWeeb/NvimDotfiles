return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "love" },
              },
              workspace = {
                library = {
                  -- Ruta donde está tu love2d dentro de mason
                  vim.fn.expand("~/.local/share/nvim/mason/packages/lua-language-server/libexec/meta/3rd/love2d"),
                },
                checkThirdParty = false,
              },
            },
          },
        },
      },
    },
  },
}
