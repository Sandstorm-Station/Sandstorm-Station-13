/// CRYPTOMINERS ///
// Should cryptominers work in non-atmos turf
/datum/config_entry/flag/crypto_ignore_atmos

// Cryptominer point multipliers
/datum/config_entry/number/crypto_multiplier_min
	config_entry_value = 0.20
	integer = FALSE

/datum/config_entry/number/crypto_multiplier_mid
	config_entry_value = 1
	integer = FALSE

/datum/config_entry/number/crypto_multiplier_max
	config_entry_value = 3
	integer = FALSE

// Cryptominer heat thresholds
/datum/config_entry/number/crypto_heat_threshold_min
	config_entry_value = 225

/datum/config_entry/number/crypto_heat_threshold_mid
	config_entry_value = 273

/datum/config_entry/number/crypto_heat_threshold_max
	config_entry_value = 500

// Cryptominer heat produced
/datum/config_entry/number/crypto_heat_power
	config_entry_value = 100

/*
 * The contained configuration values are currently unimplemented
 *
// Cryptominer processing time
/datum/config_entry/number/crypto_mining_time
	config_entry_value = 3000

// Cryptominer base payout
/datum/config_entry/number/crypto_payout_amount
	config_entry_value = 50

// Cryptominer power use
/datum/config_entry/number/crypto_power_use_idle
	config_entry_value = 20

/datum/config_entry/number/crypto_power_use_active
	config_entry_value = 200

/datum/config_entry/number/crypto_power_use_process
	config_entry_value = 20
*/

/// AUTODOC ///
// Autodoc processing time
/datum/config_entry/number/autodoc_time_surgery_base
	config_entry_value = 350

/// BLUESPACE MINER ///
// BSM production output multiplier
/datum/config_entry/number/bluespaceminer_mult_output
	config_entry_value = 1

// BSM minimum tier for bluespace crystals
/datum/config_entry/number/bluespaceminer_crystal_tier
	config_entry_value = 5

/// TETRIS ARCADE MACHINE ///
// If the machine should skip producing science points
/datum/config_entry/flag/tetris_no_science

// Points required per prize vended
/datum/config_entry/number/tetris_reward_divisor
	config_entry_value = 1000

// Points required per prize vended
/datum/config_entry/number/tetris_prizes_max
	config_entry_value = 5

// Minimum score required to message admins
/datum/config_entry/number/tetris_score_high
	config_entry_value = 10000

// Maximum research points that can be generated
/datum/config_entry/number/tetris_score_max
	config_entry_value = 100000

// Maximum research points that can be generated
/datum/config_entry/number/tetris_score_max_sci
	config_entry_value = 10000

// Minimum time between giving rewards
/datum/config_entry/number/tetris_time_cooldown
	config_entry_value = 600

/// R&D Machinery ///
// Should production machinery be restricted for skeleton crews?
/datum/config_entry/flag/protolock_during_lowpop
