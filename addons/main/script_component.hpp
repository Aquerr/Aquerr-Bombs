#define COMPONENT main
#include "\z\abombs\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_MAIN
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "\z\abombs\addons\main\script_macros.hpp"
// Include BI DIK codes
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

// Include common grids
#include "\a3\ui_f\hpp\defineCommonGrids.inc"

#define SIZEX ((safeZoneW / safeZoneH) min 1.2)
#define SIZEY (SIZEX / 1.2)
#define W_PART(num) (num * (SIZEX / 40))
#define H_PART(num) (num * (SIZEY / 25))
#define X_PART(num) (W_PART(num) + (safeZoneX + (safeZoneW - SIZEX) / 2))
#define Y_PART(num) (H_PART(num) + (safeZoneY + (safeZoneH - SIZEY) / 2))

// #define UI_X(numPx) (safeZoneX + (pixelW * numPx))
// #define UI_Y(numPx) (safeZoneY + (pixelH * numPx))
// #define UI_W(numPx) (safeZoneW / (pixelW * numPx))
// #define UI_H(numPx) (safeZoneH / (pixelH * numPx))

// pixel grids macros
#define UI_GRID_W (pixelW * pixelGrid)
#define UI_GRID_H (pixelH * pixelGrid)
#define UI_GUTTER_W (pixelW * 2)
#define UI_GUTTER_H (pixelH * 2)

#define UI_X(num) (safeZoneX + safeZoneW - ((num) + UI_GUTTER_W))
#define UI_Y(num) ((safeZoneY + UI_GUTTER_H) * num)
#define UI_W(num) (UI_GRID_W * num)
#define UI_H(num) (UI_GRID_H * num)
