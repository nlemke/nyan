levelsof country, local(levels)
foreach l of local levels {
display  `l'
reg lnwage hours educ literacy yos if country == `l'
}
display '"country number "' as result`l'

reg lnwage hours educ literacy yos if country == `l'
