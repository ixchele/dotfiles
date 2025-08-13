vim.api.nvim_create_user_command("OpenAll", function()
    -- Récupère le dossier courant dans Neovim
    local cwd = vim.fn.getcwd()

    -- Trouver tous les fichiers dans le dossier courant et ses sous-dossiers
    local files = vim.fn.glob(cwd .. "/**/*", true, true)

    -- Vérifier si des fichiers ont été trouvés
    if type(files) == "table" and #files == 0 then
        print("Aucun fichier trouvé dans : " .. cwd)
        return
    end

    -- Filtrer pour ne garder que les fichiers (exclure les dossiers)
    local valid_files = {}
    for _, file in ipairs(files) do
        if vim.fn.isdirectory(file) == 0 then
            table.insert(valid_files, vim.fn.fnameescape(file)) -- Protéger les espaces et caractères spéciaux
        end
    end

    -- Vérifier si des fichiers valides existent
    if #valid_files == 0 then
        print("Aucun fichier valide trouvé dans : " .. cwd)
        return
    end

    -- Ouvrir tous les fichiers trouvés
    vim.cmd("edit " .. table.concat(valid_files, " | edit "))
end, {})

