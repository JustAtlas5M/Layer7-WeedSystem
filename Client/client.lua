local markersShown = {
    collection = false,  -- False shows the Marker | True hides it
    processing = false,  -- False shows the Marker | True hides it
}

local ox = exports.ox_inventory

Citizen.CreateThread(function()
    for k, v in ipairs(Config.Drugs) do
        CreateMarker("collection", k, v.collection_position, "COLLECTION " .. v.name, function()
            TriggerEvent("layer7weed:progressbarcollection", k)
            markersShown.collection = true
        end)
        CreateMarker("processing", k, v.processing_position, "PROCESSING " .. v.name, function()
            TriggerEvent("layer7weed:checkitemprocessing", k)
            markersShown.processing = true
        end)       
    end
end)

function CreateMarker(category, index, position, message, action)
    local markerName = category .. "drug" .. index
    if not markersShown[category] then
        TriggerEvent('gridsystem:registerMarker', {
            name = markerName,
            pos = position,
            scale = vector3(1.0, 1.0, 1.0),
            msg = message,
            control = 'E',
            type = Config.Type,
            texture = Config.TextureName,
            color = { r = 0, g = 255, b = 0 },
            action = action
        })
    end
end

-- PROGRESS BAR
function ShowProgressBar(label, onComplete, duration)
    local options = {
        Async = true,
        canCancel = true,
        cancelKey = 178,
        x = 0.5,
        y = 0.5,
        From = 0,
        To = 100,
        Duration = duration or 1000,
        Radius = 60,
        Stroke = 10,
        Cap = 'butt',
        Padding = 0,
        MaxAngle = 360,
        Rotation = 0,
        Width = 300,
        Height = 40,
        ShowTimer = true,
        ShowProgress = false,
        Easing = "easeLinear",
        Label = label,
        LabelPosition = "bottom",
        Color = "rgba(255, 255, 255, 1.0)",
        BGColor = "rgba(0, 0, 0, 0.4)",
        Animation = {
            animationDictionary = "mini@repair",
            animationName = "fixing_a_ped",
        },
        DisableControls = {
            Vehicle = true
        },    
        onStart = function()
        end,
        onComplete = onComplete
    }
    
    if Config.rprogress then
        exports.rprogress:Custom(options)
    else
        lib.progressCircle({
            duration = options.Duration,
            position = 'middle',
            label = label,
            useWhileDead = false,
            canCancel = options.canCancel,
            disable = options.DisableControls,
            anim = {
                dict = options.Animation.animationDictionary,
                clip = options.Animation.animationName
            }
        })
        if onComplete then
            onComplete()
        end
    end
end

RegisterNetEvent("layer7weed:progressbarcollection")
AddEventHandler("layer7weed:progressbarcollection", function(drugId)
    local onComplete = function(cancelled)
        TriggerServerEvent("layer7weed:giveitemdrug", drugId)
    end
    ShowProgressBar("Collecting drugs", onComplete, Config.Duration)
end)

RegisterNetEvent("layer7weed:checkitemprocessing")
AddEventHandler("layer7weed:checkitemprocessing", function(drugId)
    local ID = source
    local drug = Config.Drugs[drugId]
    local onComplete = function(cancelled)
        TriggerServerEvent("layer7weed:giveitemprocessing", drugId)
    end
    local hasDrug = ox:Search('count', drug.itemToCollect) 
    if hasDrug < drug.processingQuantity then
        ESX.ShowNotification("You don't have enough drugs to process!")
    else
        ShowProgressBar("Processing drugs", onComplete, Config.Duration)
    end
end)

Citizen.CreateThread(function()
    -- Add blips for collection, processing, and selling positions
    for _, drug in ipairs(Config.Drugs) do
        -- Blip for collection position
        if Config.CollectionBlipActive then
            local collectionBlip = AddBlipForCoord(drug.collection_position)
            SetBlipSprite(collectionBlip, 496) -- change blip code based on what you want to show on the minimap
            SetBlipDisplay(collectionBlip, 4)
            SetBlipScale(collectionBlip, 1.3)
            SetBlipColour(collectionBlip, 2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cannabis Collection")
            EndTextCommandSetBlipName(collectionBlip)
        end

        -- Blip for processing position
        if Config.ProcessingBlipActive then
            local processingBlip = AddBlipForCoord(drug.processing_position)
            SetBlipSprite(processingBlip, 469) -- change blip code based on what you want to show on the minimap
            SetBlipDisplay(processingBlip, 4)
            SetBlipScale(processingBlip, 1.3)
            SetBlipColour(processingBlip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Hashish Processing")
            EndTextCommandSetBlipName(processingBlip)
        end        
    end
end)
