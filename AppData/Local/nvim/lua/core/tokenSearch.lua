local ts_utils = require("nvim-treesitter.ts_utils")

local function split_identifier(name)
        local tokens = {}

        -- normalize separators
        name = name:gsub("[-_]", " ")

        for part in name:gmatch("%S+") do
                local i = 1
                while i <= #part do
                        -- match acronym (ALL CAPS)
                        local s, e = part:find("^%u+", i)
                        if s then
                                -- but don't eat the first capital of a normal word
                                local next_char = part:sub(e + 1, e + 1)
                                if next_char ~= "" and next_char:match("%l") then
                                        -- single capital starting a word
                                        s, e = part:find("^%u%l+", i)
                                end
                        else
                                -- normal word
                                s, e = part:find("^%u?%l+", i)
                        end

                        if not s then
                                break
                        end

                        table.insert(tokens, part:sub(s, e):lower())
                        i = e + 1
                end
        end

        return tokens
end

local function tokenset(tokens)
        local set = {}
        for _, t in ipairs(tokens) do
                set[t] = true
        end
        return set
end

local function contains_all(haystack, needle)
        for k in pairs(needle) do
                if not haystack[k] then
                        return false
                end
        end
        return true
end

local ts = vim.treesitter

local function smart_search(query)
        local q_tokens = tokenset(split_identifier(query))

        local bufnr = vim.api.nvim_get_current_buf()
        local lang = ts.language.get_lang(vim.bo.filetype)
        local parser = ts.get_parser(bufnr, lang)

        if not parser or not lang then
                vim.print((not parser and "parser is nil") or "lang is nil")
                return
        end

        local tree = parser:parse()[1]
        local root = tree:root()

        local results = {}

        -- Tree-sitter query: identifiers only
        local query_obj = ts.query.parse(
                lang,
                [[
    (identifier) @id
  ]]
        )

        for _, node in query_obj:iter_captures(root, bufnr) do
                local text = ts.get_node_text(node, bufnr)
                local id_tokens = tokenset(split_identifier(text))

                if contains_all(id_tokens, q_tokens) then
                        table.insert(results, {
                                text = text,
                                range = { node:range() },
                        })
                end
        end

        return results
end

vim.print(smart_search("node_text_get"))
