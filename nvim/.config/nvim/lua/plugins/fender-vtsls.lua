-- Fender (Yarn PnP): point vtsls at the workspace TypeScript SDK so
-- `import … from "react"` resolves. Only applies under the fender repo.
--
-- Restart after edit: :LspRestart  (or reopen the buffer)
--
-- Neovim 0.11+ root_dir signature: function(bufnr, on_dir)

local FENDER_ROOT = "/Users/zach.croft/klaviyo/Repos/fender"
local FENDER_TS_SDK = FENDER_ROOT .. "/.yarn/sdks/typescript/lib"

---@param path_or_bufnr string|number|nil
---@return string
local function to_path(path_or_bufnr)
  if type(path_or_bufnr) == "number" then
    local name = vim.api.nvim_buf_get_name(path_or_bufnr)
    if name ~= "" then
      return vim.fs.normalize(name)
    end
    return vim.fs.normalize(vim.fn.getcwd())
  end
  if type(path_or_bufnr) == "string" and path_or_bufnr ~= "" then
    return vim.fs.normalize(path_or_bufnr)
  end
  return vim.fs.normalize(vim.fn.getcwd())
end

---@param path string
---@return boolean
local function under_fender(path)
  path = to_path(path)
  if path == "" then
    return false
  end
  local root = vim.fs.normalize(FENDER_ROOT)
  return path == root or vim.startswith(path, root .. "/")
end

---@param path_or_bufnr string|number
---@return string|nil
local function fender_root(path_or_bufnr)
  local path = to_path(path_or_bufnr)
  if not under_fender(path) then
    return nil
  end
  -- Prefer monorepo root (.pnp.cjs / .yarnrc.yml), not a nested package.json
  -- vim.fs.root accepts a bufnr or a path.
  local root = vim.fs.root(path_or_bufnr, { ".pnp.cjs", ".yarnrc.yml" })
  if root and under_fender(root) then
    return root
  end
  return FENDER_ROOT
end

---@param root_dir string|nil
local function apply_fender_tsdk(config, root_dir)
  if not under_fender(root_dir or "") then
    return
  end
  config.settings = config.settings or {}
  config.settings.typescript = config.settings.typescript or {}
  config.settings.typescript.tsdk = FENDER_TS_SDK
  config.settings.javascript = config.settings.javascript or {}
  config.settings.javascript.tsdk = FENDER_TS_SDK
  config.settings.vtsls = config.settings.vtsls or {}
  config.settings.vtsls.autoUseWorkspaceTsdk = true
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      local vtsls = opts.servers.vtsls or {}

      -- Modern nvim 0.11+ / LazyVim signature (see oxc extra): (bufnr, on_dir)
      vtsls.root_dir = function(bufnr, on_dir)
        local root = fender_root(bufnr)
        if not root then
          local fname = to_path(bufnr)
          root = require("lspconfig.util").root_pattern(
            "tsconfig.json",
            "jsconfig.json",
            "package.json"
          )(fname)
        end
        if root then
          on_dir(root)
        end
      end

      -- Prefer before_init: on_new_config is unreliable on newer lspconfig/nvim
      local prev_before_init = vtsls.before_init
      vtsls.before_init = function(params, config)
        if prev_before_init then
          prev_before_init(params, config)
        end
        local root = config.root_dir
        if (not root or root == "") and params.rootUri then
          root = vim.uri_to_fname(params.rootUri)
        end
        apply_fender_tsdk(config, root)
      end

      local prev_on_new_config = vtsls.on_new_config
      vtsls.on_new_config = function(config, root_dir)
        if prev_on_new_config then
          prev_on_new_config(config, root_dir)
        end
        apply_fender_tsdk(config, root_dir)
      end

      opts.servers.vtsls = vtsls
    end,
  },
}
