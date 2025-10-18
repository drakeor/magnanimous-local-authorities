# Magnanimous Local Authorities

This OpenTTD GameScript ensures that your relationship with local authorities doesn't stay terrible for past transgressions. It periodically improves town ratings for all human players, gradually restoring them to a configurable maximum. This allows for recovery from "accidental" reputation damage like demolishing a children's hospital or poisoning the water supply.

## How It Works

The script runs in the background and, at regular intervals, increases the town authority rating for each human-controlled company in every town on the map, up to a specified cap.

## Configuration

You can adjust the following settings in-game via the GameScript options:

*   **`recovery_amount`**: The number of rating points to add during each recovery pulse.
    *   *Default*: 25
*   **`recovery_period_ticks`**: The time in script ticks between each recovery pulse.
    *   *Default*: 60
*   **`max_rating`**: The maximum rating you can recover to. The highest possible in OpenTTD is 1000 ("Outstanding").
    *   *Default*: 1000
*   **`debug_mode`**: When enabled, every rating adjustment will be logged to the console.
    *   *Default*: Enabled on Easy, disabled otherwise.