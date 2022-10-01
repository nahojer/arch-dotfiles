vim.opt_local.wrap = true

-- match and highlight hyperlinks
vim.cmd "hi matchURL guifg=DodgerBlue"
vim.fn.matchadd("matchURL", [[http[s]\?:\/\/[[:alnum:]%\/_#.-]*]])

vim.cmd [[setlocal foldlevel=99 conceallevel=0]]
