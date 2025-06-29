#define CBA_SETTINGS_CAT LSTRING(settingsAquerrBombsCategory)

// Show bomb icons in zeus interface
[
    QGVAR(zeusShowBombIcons),
    "CHECKBOX",
    CSTRING(settingsZeusShowBombIcons),
    [CBA_SETTINGS_CAT, CSTRING(settingsZeusSubCategory)],
    [true]
] call CBA_fnc_addSetting;