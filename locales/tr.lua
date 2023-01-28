local Translations = {
    success = {
        ["vehicle_fixed"] = "Araba tamir edildi!", 
        ["full_mods"] = "Araç modları fullendi!",
        ["changed_livery"] = "Araç çıkartması değiştirildi!", 

    },
    error = {
        ["action_canceled"] = "İşlem iptal edildi!",
        ["not_allowed"] = "Bu araç bu işlem için uygun değil!",
    }
    
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
