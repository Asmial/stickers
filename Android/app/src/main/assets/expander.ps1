"{`"android_play_store_link`":`"`",`"ios_app_store_link`":`"`",`"sticker_packs`":[" > .\contents.json

$files = Get-ChildItem -Path *.wastickers
foreach ($i in $files) {
    "{" >> .\contents.json
    $identifier = $i.Name -replace "\.wastickers$", ""
    Remove-Item -Path $identifier -Recurse -Force -ErrorAction Ignore 
    New-Item -Path $identifier -ItemType Directory -ErrorAction Ignore
    Expand-Archive -Path $i -DestinationPath $identifier
    $name = $(Get-Content "$identifier/title.txt" | Out-String).Split([Environment]::NewLine)[0]
    $publisher = $(Get-Content "$identifier/author.txt" | Out-String).Split([Environment]::NewLine)[0]
    $tray_image_file = $(Get-ChildItem -Path $identifier  -Filter *.png)[0].Name

    

    "
    `"identifier`": `"$identifier`",
    `"name`": `"$name`",
    `"publisher`": `"$publisher`",
    `"tray_image_file`": `"$tray_image_file`",
    `"image_data_version`": `"1`",
    `"avoid_cache`": false,
    `"publisher_email`": `"`",
    `"publisher_website`": `"`",
    `"privacy_policy_website`": `"`",
    `"license_agreement_website`": `"`",
    `"stickers`":[" >> .\contents.json

    $webps = $(Get-ChildItem -Path $identifier -Filter "*.webp")
    foreach ($j in $webps) {
        "{`"image_file`": `"$($j.Name)`", `"emojis`": [`"🐨`"]}" >> .\contents.json
        if ($j -ne $webps[-1]) {
            "," >> .\contents.json
        }
    }
    "]}" >> .\contents.json
    if ($i -ne $files[-1]) {
        "," >> .\contents.json
    }
    else {
        "]}" >> .\contents.json
    }
    
}