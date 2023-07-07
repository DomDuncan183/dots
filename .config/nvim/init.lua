local ok, _ = pcall(require, 'lspconfig')
if not ok then
    return
end

require('core.packer')
require('core.set')
require('core.map')
require('core.themes')
require('core.tools')
require('core.lsp')
