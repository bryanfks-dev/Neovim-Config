local path_utils = require("utils.path_utils")

-- Import configs
require("config.settings")
require("config.lazy")
require("config.keymaps")
require("config.file_ext")

-- Import code snippets
local snippets_path = path_utils.get_abs_config_path({
  "lua", "snippets"
})

require("luasnip.loaders.from_lua").lazy_load({
  paths = { snippets_path }
})

