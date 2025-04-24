local kmap = vim.keymap.set
local opts = {noremap = true, silent = true}

vim.g.mapleader = " "

-- NeoTree
kmap("n", "<leader>e", ":Neotree float reveal<CR>")
kmap("n", "<leader>o", ":Neotree float git_status<CR>")

-- Навигация между окнами по кнопкам h j k l
kmap("n", "<c-k>", ":wincmd k<CR>")
kmap("n", "<c-j>", ":wincmd j<CR>")
kmap("n", "<c-h>", ":wincmd h<CR>")
kmap("n", "<c-l>", ":wincmd l<CR>")
kmap("n", "<leader>/", ":CommentToggle<CR>")

-- Other
kmap("n", "<leader>w", ":w<CR>")
kmap("i", "jj", "<Esc>")
kmap("n", "<leader>h", ":nohlsearch<CR>")

-- BufferLine
kmap("n", "<leader>x", ":BufferLinePickClose<CR>")
kmap("n", "<leader>s", ":BufferLinePick<CR>")
kmap("n", "<Tab>", ":BufferLineCycleNext<CR>")
kmap("n", "<s-Tab>", ":BufferLineCyclePrev<CR>")

-- Terminal
kmap("n", "<leader>tf", ":ToggleTerm direction=float<CR>")
kmap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>")
kmap("n", "<leader>tv", ":ToggleTerm direction=vertical size=40<CR>")

kmap("n", "gdt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)

-- Toggle relative line number
kmap("n", "<c-l><c-l>", ":set invrelativenumber<CR>")
--[[
pell
:set nospell  - чтобы отключить подсветку ошибок

для выбора подходящих слов
z= появится сокращенный список
z=z появится полный список

для исправления в режиме редактирования
<c-x><c-s>
--]]
kmap("n", ",s", function()
    vim.wo.spell = true
    vim.opt.spelllang = {"en_us", "ru_ru"}
end)

-- quickfix
kmap("n", "<leader>co", ":copen<CR>")
kmap("n", "<leader>cx", ":cclose<CR>")
kmap("n", "<leader>cn", ":cnext<CR>")
kmap("n", "<leader>cp", ":cprev<CR>")
