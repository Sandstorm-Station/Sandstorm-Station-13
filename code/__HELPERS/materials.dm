/// Turns a material amount into the amount of sheets it should output
/proc/amount2sheet(amount)
	if(amount >= MINERAL_MATERIAL_AMOUNT)
		return round(amount / MINERAL_MATERIAL_AMOUNT)
	return FALSE

/// Turns an amount of sheets into the amount of material amount it should output
/proc/sheet2amount(sheet_amount)
	if(sheet_amount > 0)
		return sheet_amount * MINERAL_MATERIAL_AMOUNT
	return FALSE
