require("version.nut");

class MainClass extends GSController {
    constructor() {}
}

/* Human-only filter: company is considered “human” if there is ≥1 client in it. */
function is_human_company(company) {
    if (company == GSCompany.COMPANY_INVALID || company == GSCompany.COMPANY_SPECTATOR) return false;
    local lst = GSClientList_Company(company); // list of clients in this company
    return lst.Count() > 0;
}

/* Perform one recovery pulse: add +amount toward cap for each (town, human company). */
function recover_once(amount, cap, debug) {
    if (amount <= 0) return;

    // Clamp cap to OpenTTD bounds just in case.
    if (cap > 1000) cap = 1000;
    if (cap < -1000) cap = -1000;

    // Build the set of human companies from the currently connected clients.
    local human_companies = {};
    {
        local clients = GSClientList();
        for (local cl = clients.Begin(); !clients.IsEnd(); cl = clients.Next()) {
            local c = GSClient.GetCompany(cl);
            if (is_human_company(c)) human_companies[c] <- true;
        }
    }
    if (human_companies.len() == 0) return;

    // Apply recovery per town × human company
    local towns = GSTownList();
    for (local t = towns.Begin(); !towns.IsEnd(); t = towns.Next()) {
        if (!GSTown.IsValidTown(t)) continue;

        foreach (c, _ in human_companies) {
            local cur = GSTown.GetRating(t, c);
            if (cur >= cap) continue;
            local add = amount;
            if (cur + add > cap) add = cap - cur;
            if (add > 0) {
                GSTown.ChangeRating(t, c, add);
                local msg = "[MLA] town=" + t + " company=" + c + " +" + add + " -> " + (cur + add) + " (cap=" + cap + ")";
                GSLog.Info(msg);
            }
        }
    }
}

function MainClass::Start() {
    // Read GS Parameters (exposed via info.nut → AddSetting)
    local amount  = GSController.GetSetting("recovery_amount");       // points per pulse
    local period  = GSController.GetSetting("recovery_period_ticks"); // ticks between pulses
    local cap     = GSController.GetSetting("max_rating");            // cap toward which we recover
    local debug   = GSController.GetSetting("debug_mode") != 0;

    // Defensive defaults if settings unavailable (-1)
    if (amount  < 0) amount = 25;
    if (period  < 1) period = 60;
    if (cap     < -1000 || cap > 1000) cap = 1000;

    GSController.Sleep(1); // settle

    GSLog.Info("Magnanimous Local Authorities loaded.");

    while (true) {
        recover_once(amount, cap, debug);
        GSController.Sleep(period); // script ticks, not wall-clock seconds
    }
}

function MainClass::Save() { return {}; }
function MainClass::Load(_v, _t) {}
