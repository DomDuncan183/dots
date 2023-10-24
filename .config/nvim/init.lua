require('config.set')
require('config.map')
require('config.lazy')
if (vim.api.nvim_buf_get_name(0) == '')
    then
        vim.cmd('Ex')
    end
