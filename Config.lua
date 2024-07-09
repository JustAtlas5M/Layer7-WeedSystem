Config = {}

-- General Settings
Config.Type = 2  -- Marker type
Config.TextureName = "general" -- Texture name
Config.rprogress = true  -- Use rprogress script? If set to false, it will use LIB's progress bar
Config.Duration = 2000 -- Duration of the progress bar for each process

-- Drugs settings
Config.Drugs = {
    {
        name = "Marijuana",
        collection_position = vector3(2220.2971, 5578.0869, 53.7254),  -- Set the coordinates
        processing_position = vector3(-1.0923, -2497.3513, -8.9624),
        itemToCollect = "unprocessed_marijuana",
        processedItem = "processed_marijuana",
        processingQuantity = 2,
        processingResultQuantity = 1,
        collectionQuantity = 1,
        unitPrice = 300,
    },
    --[[{
        name = "drug name",
        collection_position = vector3(coordinates),
        processing_position = vector3(coordinates),
        sale_position = vector3(coordinates),
        itemToCollect = "item_name",
        processedItem = "item_name",
        processingQuantity = X,
        processingResultQuantity = X,
        collectionQuantity = X,
    },]]
    -- You can add as many drugs as you want!
}

-- Settings to enable or disable blips
Config.CollectionBlipActive = true  
Config.ProcessingBlipActive = true


-- LAYER 7