function onTabletopInit()
    OptionsManager.registerOption2(
        "SHAREDRECORD",
        false,
        "option_header_SharedRecord",
        "option_label_SHAREDRECORD",
        "option_entry_cycler",
        {
            labels = "UNC",
            values = "unc",
            baselabel = "UNSHARE",
            baseval = "unshare",
            default = "UNSHARE"
        }
    )
end

