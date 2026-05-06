vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    if vim.treesitter.language.get_lang(ft) then
      pcall(vim.treesitter.start, args.buf)
    end
  end,
})
