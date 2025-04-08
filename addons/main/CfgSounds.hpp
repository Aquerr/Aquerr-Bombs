class CfgSounds {
    sounds[] = {};

    class GVAR(BombBeep) {
        name = QGVAR(BombBeep);
        sound[] = {QPATHTOF(sounds\bomb_beep.ogg), "db + 2", 1, 15};
        titles[] = {};
    };

    class GVAR(BombDefuse) {
        name = QGVAR(BombDefuse);
        sound[] = {QPATHTOF(sounds\bomb_defuse.ogg), "db + 2", 1, 15};
        titles[] = {};
    };
};