#define isclownjob(x) (_isclownjob(x))

#define isqareen(A) (istype(A, /mob/living/simple_animal/qareen))

// Hyperstation Stuff
#define iswendigo(A) (istype(A, /mob/living/carbon/wendigo))

#define iscloudturf(A) (istype(A, /turf/open/chasm/cloud))

#define isarachnid(A) (is_species(A, /datum/species/arachnid) || HAS_TRAIT(A, TRAIT_ARACHNID))
