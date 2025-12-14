local function debounce(fn, delay)
        local timer = vim.loop.new_timer()
        return function(...)
                local args = { ... }
                timer:stop()
                timer:start(delay, 0, function()
                        vim.schedule(function()
                                fn(unpack(args))
                        end)
                end)
        end
end
