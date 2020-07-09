RMenu.Add('showcase', 'main', RageUI.CreateMenu("RageUI", "Undefined for using SetSubtitle"))
RMenu:Get('showcase', 'main'):SetSubtitle("~b~RedSide Event")
RMenu:Get('showcase', 'main').EnableMouse = false
RMenu:Get('showcase', 'main').Closed = function()
    -- TODO Perform action
end;


local startPos = nil
local endPos = nil
local desc = ""
local NombreJoueurs = nil
local typeVeh = ""
local prix = 0
local ArgentPropre = false




local participantMax = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
}

local index = {
    participant = 1,
}


RageUI.CreateWhile(5.0, function()

    if IsControlJustPressed(1, 57) then
        if GetPlayerName(PlayerId()) == "Alexis Lafaille" or GetPlayerName(PlayerId()) == "SanGlitcher" or GetPlayerName(PlayerId()) == "[C.F]Skyles" then
            RageUI.Visible(RMenu:Get('showcase', 'main'), not RageUI.Visible(RMenu:Get('showcase', 'main')))
        end
    end


    if RageUI.Visible(RMenu:Get('showcase', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Button("Fixé la pos start", "Determine la position de dépars", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    startPos = GetEntityCoords(GetPlayerPed(-1))
                    RageUI.Popup({
                        message = "~g~Coordonée de début définit"
                    })
                end
            end)
            RageUI.Button("Fixé la pos de fin", "Determine la position de fin", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    endPos = GetEntityCoords(GetPlayerPed(-1))
                    RageUI.Popup({
                        message = "~g~Coordonée de fin définit"
                    })
                end
            end)
            RageUI.Button("Fixé la déscription de l'évent", "Desc: "..desc, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    AddTextEntry("Déscription évent", "")
                    DisplayOnscreenKeyboard(1, "Déscription évent", '', "", '', '', '', 256)
                
                    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                        Citizen.Wait(0)
                    end
                
                    if UpdateOnscreenKeyboard() ~= 2 then
                        desc = GetOnscreenKeyboardResult()
                        Citizen.Wait(1)
                    else
                        Citizen.Wait(1)
                    end
                end
            end)
            RageUI.List("Nombre de participants", participantMax, index.participant, "Select the type of food you want to eat.", {}, true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    NombreJoueurs = Index;
                end
                index.participant = Index;
            end)
            RageUI.Button("Fixé le véhicule de l'event", "Véhicule: "..typeVeh, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    AddTextEntry("VehEvent", "")
                    DisplayOnscreenKeyboard(1, "VehEvent", '', "", '', '', '', 20)
                
                    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                        Citizen.Wait(0)
                    end
                
                    if UpdateOnscreenKeyboard() ~= 2 then
                        typeVeh = GetOnscreenKeyboardResult()
                        Citizen.Wait(1)
                    else
                        Citizen.Wait(1)
                    end
                end
            end)
            RageUI.Button("Fixé le prix", "Prix: "..prix, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    AddTextEntry("Déscription évent", "")
                    DisplayOnscreenKeyboard(1, "Déscription évent", '', "", '', '', '', 20)
                
                    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                        Citizen.Wait(0)
                    end
                
                    if UpdateOnscreenKeyboard() ~= 2 then
                        prix = tonumber(GetOnscreenKeyboardResult())
                        Citizen.Wait(1)
                    else
                        Citizen.Wait(1)
                    end
                end
            end)
            RageUI.Checkbox("Argent propre ?", "Si activer, l'argent reçu sera de l'argent propre.", ArgentPropre, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                ArgentPropre = Checked;
            end)
            RageUI.Button("~g~Validé l'évent", "Commencer l'évent", {}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("LS_EVENT:SendInfo", startPos, endPos, desc, index.participant, typeVeh, prix, ArgentPropre)
                end
            end)
        end)
    end
end, 1)