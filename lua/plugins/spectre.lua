require('spectre').setup()

vim.keymap.set('n', ',st', '<cmd>lua require("spectre").toggle()<CR>',
               {desc = "Toggle Spectre"})
vim.keymap.set('n', ',sw',
               '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
               {desc = "Search current word"})
vim.keymap.set('v', ',sw', '<esc><cmd>lua require("spectre").open_visual()<CR>',
               {desc = "Search current word"})
vim.keymap.set('n', ',sp',
               '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
               {desc = "Search on current file"})
