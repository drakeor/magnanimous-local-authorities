require("version.nut");

class FMainClass extends GSInfo {
    function GetAuthor()      { return "Drakeor"; }
    function GetName()        { return "Magnanimous Local Authorities"; }
    function GetDescription() { return "Periodically restores human players' town ratings over time to a configurable maximum."; }
    function GetVersion()     { return SELF_VERSION; }
    function GetDate()        { return "2025-10-18"; }
    function CreateInstance() { return "MainClass"; }
    function GetShortName()   { return "MLA"; }
    function GetAPIVersion()  { return "1.10"; }
    function GetURL()         { return "https://example.invalid/aorh"; }

    /* Declare real GS Parameters shown in-game (AI/GS settings → GS Parameters). */
    function GetSettings() {
        AddSetting({
            name        = "recovery_amount",
            description = "Rating points added per pulse to each (town, human company).",
            easy_value  = 25, medium_value = 25, hard_value = 25,
            flags       = 0, min_value = 0, max_value = 200, step_size = 1
        });
        AddSetting({
            name        = "recovery_period_ticks",
            description = "Script ticks between recovery pulses (not real seconds).",
            easy_value  = 60, medium_value = 60, hard_value = 60,
            flags       = 0, min_value = 1, max_value = 10000, step_size = 1
        });
        AddSetting({
            name        = "max_rating",
            description = "Maximum rating to recover to (≤ 1000 = Outstanding).",
            easy_value  = 1000, medium_value = 1000, hard_value = 1000,
            flags       = 0, min_value = -1000, max_value = 1000, step_size = 1
        });
        AddSetting({
            name        = "debug_mode",
            description = "When enabled, log each adjustment to the GS console.",
            easy_value  = 1, medium_value = 0, hard_value = 0,
            flags       = 0, min_value = 0, max_value = 1, step_size = 1
        });
    }
}
RegisterGS(FMainClass());
