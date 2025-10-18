/*
 * Always Outstanding Ratings (AOR) config
 * All time units are SCRIPT TICKS (GameScript ticks), not real seconds.
 */
CONFIG <- {
    // Add this many rating points per recovery pulse to each (town, human company).
    recovery_amount = 25,

    // How often to apply recovery (in script ticks).
    recovery_period_ticks = 60,

    // Maximum rating to recover to (clamped to OpenTTD’s ±1000 range).
    max_rating = 1000,

    // When true, log each adjustment.
    debug = true,
};
