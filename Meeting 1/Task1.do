/* File created by Trudie Schils, April 16 2009 */
/* Background analyses for task 1 course 1152M */

/* The basics */

cd "C:\Users\Eva Feron\Documents\Tutor UM\Intellectual capital and knowledge systems\Data"

log using Task2_1

use ials.dta

ta sex /* shows gender distribution of sample */

tabstat wage, stat(mean, sd) by(country) /* shows mean wage and standard deviation by country */

tabstat wage, stat(p10, p90) by(country) /* shows 10th and 90th percentile of wage distribution by country */

ta country sex, ro nof /* shows gender distribution of sample by country in percentages */


/* MANIPULATION */

gen lnw = ln(wage) /* creates a new variable for each individual, taking the log of wage */

lab var lnw "Log wages" /* adds a label to the newly created variable */

gen hw = wage / hours /* creates a new variable for each individual, defining the hourly wage */

gen lhw = ln(hw) /* creates a new variable for each individual, taking the log of hourly wages */

reg lnw yos if country==11 & sex==0 & age>=35 /* regresses years of schooling on log wages for Swedish men aged over 35 */

gen agesq = age * age /* creates a new variable for each individual, taking age squared */

reg lnw yos sex age agesq if country==11 /* regresses years of schooling, sex, age and age squared on log wages in Sweden*/



/* DUMMIES */

reg lnw sex /* regresses sex on log wages */

reg lnw literacy  /* regresses literacy on log wages for all countries */

xi: reg lnw literacy i.country



/* GRAPHS */

histogram age

histogram literacy if country==5 | country==6, by(country)



