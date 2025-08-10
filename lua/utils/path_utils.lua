local M = {}

-- get_abs_config_path is an utility function that returns the absolute path to a
-- configuration file based on the system used. It takes a table of additional paths as
-- an argument and constructs the absolute path accordingly.
--
-- @param {add_paths} table - A table containing additional paths to be included in the
--                            absolute path.
--
-- @return {string} - The absolute path to the configuration file.
function M.get_abs_config_path(add_paths)
  assert(add_paths, "Please provide additional path in get_abs_config_path")
  assert(type(add_paths) == "table", "Please provide a table in get_abs_config_path")

  local config_path = vim.fn.stdpath("config")

  -- Initialize the joined additional paths variable
  local joined_add_paths = ""

  -- Get the system used
  local system = vim.loop.os_uname().sysname

  -- Join the additional paths with the system-specific separator
  if system == "Windows_NT" then
    joined_add_paths = table.concat(add_paths, "\\")

    return config_path .. "\\" .. joined_add_paths
  end

  joined_add_paths = table.concat(add_paths, "/")

  return config_path .. "/" .. joined_add_paths
end

return M
