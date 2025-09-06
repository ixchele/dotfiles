local M = {}

function M.ExtractFunctionPrototypes()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local prototypes = {}
  local keywords = { "if", "while", "for", "switch", "else", "else if" }

  local function starts_with_keyword(line)
    line = line:gsub("^%s*", "")
    for _, kw in ipairs(keywords) do
      if line:match("^" .. kw .. "%s*%(") or line == kw then
        return true
      end
    end
    return false
  end

  local function split_type_and_name(proto)
    local pos_paren = proto:find("%(")
    if not pos_paren then return nil, nil end
    local before_paren = proto:sub(1, pos_paren - 1)
    local after_paren = proto:sub(pos_paren)
    local words = {}
    for word in before_paren:gmatch("%S+") do
      table.insert(words, word)
    end
    local name = words[#words]
    table.remove(words, #words)
    local ret_type = table.concat(words, " ")
    return ret_type, name .. after_paren
  end

  for i = 2, #lines do
    if lines[i]:find("{") then
      local candidate = lines[i - 1]
      if candidate and not candidate:find("static") and candidate:match("%w") then
        candidate = candidate:gsub("^%s*", ""):gsub("%s*$", "")
        if not starts_with_keyword(candidate) then
          local ret_type, name_and_args = split_type_and_name(candidate)
          if ret_type and name_and_args and not name_and_args:match("^main%s*%(") then
            table.insert(prototypes, {ret_type = ret_type, name_and_args = name_and_args})
          end
        end
      end
    end
  end

  if #prototypes == 0 then
    print("❌ Aucun prototype valide trouvé.")
    return
  end

  -- Trouver la longueur max du type
  local max_len = 0
  for _, p in ipairs(prototypes) do
    if #p.ret_type > max_len then
      max_len = #p.ret_type
    end
  end

  local tabsize = 8

  local function tabs_for_length(len)
    local target_col = max_len + 1
    local tabs_needed = math.ceil((target_col - len) / tabsize)
    if tabs_needed < 1 then
      tabs_needed = 1
    end
    return string.rep("\t", tabs_needed)
  end

  local formatted = {}
  for _, p in ipairs(prototypes) do
    local tabs = tabs_for_length(#p.ret_type)
    table.insert(formatted, p.ret_type .. tabs .. p.name_and_args .. ";")
  end

  local output = table.concat(formatted, "\n") .. "\n"
  vim.fn.setreg("+", output)
  print("✅ Prototypes copiés dans le presse-papier (avec tabulations uniquement).")
end

return M
