return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_default_mappings = 1 -- active les mappings par défaut
      vim.g.VM_maps = {
        ["Find Under"]         = "<C-n>", -- sélection du mot sous le curseur
        ["Find Subword Under"] = "<C-n>", -- pareil pour les sous-mots
      }
    end,
  },
}
