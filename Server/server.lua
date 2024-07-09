RegisterNetEvent("layer7weed:giveitemprocessing")
AddEventHandler("layer7weed:giveitemprocessing", function(drugId)
    local ID = source
    local drug = Config.Drugs[drugId]
    exports.ox_inventory:RemoveItem(ID, drug.itemToCollect, drug.processingQuantity)
    exports.ox_inventory:AddItem(ID, drug.processedItem, drug.processingResultQuantity)
    TriggerClientEvent('okokNotify:Alert', ID, 'Drugs', 'Drugs processed successfully', 2000, 'success', true) -- Change the export based on your usage
end)

RegisterNetEvent("layer7weed:giveitemdrug")
AddEventHandler("layer7weed:giveitemdrug", function(drugId)
    local ID = source
    local drug = Config.Drugs[drugId]
    if drug then
        exports.ox_inventory:AddItem(ID, drug.itemToCollect, drug.collectionQuantity)
        TriggerClientEvent('okokNotify:Alert', ID, 'Drugs', 'Drugs collected successfully', 2000, 'info', true) -- Change the export based on your usage
    end
end)
