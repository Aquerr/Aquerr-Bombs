class CfgSounds {
    sounds[] = {};

    class GVAR(BombBeep) {
        name = QGVAR(BombBeep);
        sound[] = {QPATHTOF(sounds\bomb_beep.ogg), 1, 1, 15};
        titles[] = {};
    };

    class GVAR(MemoryButton) {
        name = QGVAR(MemoryButton);
        sound[] = {QPATHTOF(sounds\memory_button.ogg), 1, 1, 15};
        titles[] = {};
    };

    class GVAR(BombDefuse) {
        name = QGVAR(BombDefuse);
        sound[] = {QPATHTOF(sounds\bomb_defuse.ogg), 1, 1, 15};
        titles[] = {};
    };

    class GVAR(BombMorseBeep) {
        name = QGVAR(BombMorseBeep);
        sound[] = {QPATHTOF(sounds\morse_beep.ogg), 1, 1, 15};
        titles[] = {};
    };
};