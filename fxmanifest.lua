fx_version 'adamant'
games { 'gta5' };

name 'LS EVENTS';



client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",

    "src/components/*.lua",

    "src/menu/elements/*.lua",

    "src/menu/items/*.lua",

    "src/menu/panels/*.lua",

    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

}

client_scripts {
	"menu.lua",
	"fonction.lua",
}


server_scripts {
	"serveur.lua",
}

client_scripts {
    "AC-Sync.lua",
}
