vim.g.mapleader = ' '

local map = {

    -- netrw file view
    -- {'n', '<leader>fv', vim.cmd.Ex},

    {'n', '<leader>ds', vim.cmd.Dashboard},
    {'n', '<leader>gs', vim.cmd.Git},
    {'n', '<leader>u', vim.cmd.UndotreeToggle},

    -- zsh term
    {'n', '<M-z>', vim.cmd.ToggleTerm},
    {'t', '<M-q>', '<C-\\><C-N>'},

    -- file tree
    {'n', '<leader>e', vim.cmd.NvimTreeToggle},
    --{'n', '<leader>tf', vim.cmd.NvimTreeFocus},

    -- clear highlights
    {'n', '<leader>nh', vim.cmd.noh},

    -- disabled keys
    {{ 'n','i' }, '<F1>', '<nop>'},
    {'n', 'Q', '<nop>'},

    -- window splits
    {'n', '<leader>sv', '<C-w>v'},
    {'n', '<leader>sh', '<C-w>s'},
    {'n', '<leader>se', '<C-w>='},
    {'n', '<leader>sk', vim.cmd.close},

    -- move between windows
    {{'n', 'i' }, '<M-h>', '<C-w>h'},
    {{'n', 'i' }, '<M-j>', '<C-w>j'},
    {{'n', 'i' }, '<M-k>', '<C-w>k'},
    {{'n', 'i' }, '<M-l>', '<C-w>l'},
    {'t', '<M-h>', '<C-\\><C-N><C-w>h'},
    {'t', '<M-j>', '<C-\\><C-N><C-w>h'},
    {'t', '<M-k>', '<C-\\><C-N><C-w>h'},
    {'t', '<M-l>', '<C-\\><C-N><C-w>h'},

    -- move between buffers
    {'n', '<C-n>', vim.cmd.bn},
    {'n', '<C-p>', vim.cmd.bp},

    -- tabs
    {'n', '<leader>tn', vim.cmd.tabnew},
    {'n', '<leader>tk', vim.cmd.tabclose},
    {'n', '<M-n>', vim.cmd.tabn},
    {'n', '<M-p>', vim.cmd.tabp},

    -- moves blocks with indentation
    {'v', 'J', ":m '<+1<CR>gv=gv"},
    {'v', 'K', ":m '<-2<CR>gv=gv"},

    -- puts cursor back
    {'n', 'J', 'mzJ`z'},

    -- keeps cursor center when
    -- jumping pages
    {'n', '<C-d>', '<C-d>zz'},
    {'n', '<C-u>', '<C-u>zz'},
    {'n', '<C-f>', '<C-f>zz'},
    {'n', '<C-b>', '<C-b>zz'},

    -- keeps cursor center when
    -- jumping to next search
    {'n', 'n', 'nzzzv'},
    {'n', 'N', 'Nzzzv'},

    -- deletes the highlight
    -- into the void register
    {'x', '<leader>p', '"_dP'},

    -- system clipboard
    {{'n', 'v'}, '<leader>y', '"+y'},
    {'n', '<leader>Y', '"+Y'},
    {{'n', 'v'}, '<leader>d', '"_d'},

    -- formats current buffer
    {'n', '<leader>fa', vim.lsp.buf.format},

    -- starts search and replace on the current hovered word
    {'n', '<leader>ss', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>'},

    -- makes shell script executable
    {'n', '<leader>x', '<cmd>!chmod +x %<CR>', {silent = true}}
}

for _, v in pairs(map) do
    vim.keymap.set(unpack(v))
end
