/* Task 1: What are the differences in human capital between countries? *//* Here we see that in general the western countries have   a higher level of literacy than the eastern countries (+chile)   except czech republic */graph hbox literacy, over(country)/* Next, we see that the years of schooling do not differ that much! */graph hbox yos, over(country)/* But we see a clear difference in educational levels */graph hbox educ, over(country)graph hbar literacy yos educ, over(country) /* What is the relationship between real wage and literacy like   in the different countries? */graph twoway lfitci cvwage literacy, by(country)/* Literacy is higher when you   are not an immigrant */histogram literacygraph hbox literacy, over(born)/* But immigrants work longer hours */graph hbox hours, over(born)/* Literacy levels */gen litlevel = literacyreplace litlevel = 5 if litlevel > 375replace litlevel = 4 if litlevel > 325replace litlevel = 3 if litlevel > 275replace litlevel = 2 if litlevel > 225replace litlevel = 1 if litlevel > 5 & litlevel < 225histogram litlevelgraph hbar litlevel, over(country, sort(1) descending)graph hbox litlevel, over(country)/* Task2: How is human capital related to sex or age? *//*generate variables to improve functional form */gen sqage =  age *  agegen lnage = ln(age)gen lnhours = ln(hours)gen lnyos = ln(yos)gen lnliteracy = ln(literacy)/* simple regression */reg literacy sex age/* adding square of age */reg literacy sex age sqage reg yos sex age sqage reg educ sex age sqage /* adding country effects */xi: reg literacy sex age sqage i.countryxi: reg yos sex age sqage i.countryxi: reg educ sex age sqage i.country/* looking at percentage change */ reg lnliteracy sex age sqage reg lnyos sex age sqage xi: reg lnliteracy sex age sqage i.countryxi: reg lnyos sex age sqage i.countryreg lnliteracy sex lnage sqage reg lnyos sex lnage sqage xi: reg lnliteracy sex lnage sqage i.countryxi: reg lnyos sex lnage sqage i.country/* taking into account that education is indicated in levels*/reg educ sex lnage sqage xi: reg i.educ sex lnage sqage i.country/* Task 3: Is there a link between years of schooling and literacy? */correlate literacy yosreg literacy yos xi: reg literacy yos i.countrygraph twoway lfit literacy yos || scatter  literacy yos /*Task 4: What is the link between human capital and earnings? *//* converting wage indicators to international dollars (including ppp)    source: world bank */gen cvwage = wage / 0.988051201 if country == 5replace cvwage = wage if country == 6replace cvwage = wage / 0.905964798 if country == 8replace cvwage = wage / 1.657925035 if country == 9replace cvwage = wage / 0.808346548 if country == 17replace cvwage = wage / 9.369831211 if country == 11 replace cvwage = wage / 9.385982807 if country == 18replace cvwage = wage / 115.868782 if country == 20replace cvwage = wage / 13.89019109 if country == 21replace cvwage = wage / 8.394664991 if country == 23replace cvwage = wage / (1.002950595 * 5.94573) if country == 24replace cvwage = wage / 94.16743431 if country == 25replace cvwage = wage / 1.187534322 if country == 26replace cvwage = wage / 1.87869376  if country == 27replace cvwage = wage / 274.8650472  if country == 29gen lnwage = ln(cvwage) reg lnwage  educ literacy yosreg lnwage hours educ literacy yosreg cvwage  educ literacy yos/*Task 5: Is this relation between human capital and earnings different           between countries? */xi : reg cvwage  educ literacy yos i.countryxi : reg lnwage  educ literacy yos i.countryxi : reg lnwage  educ lnliteracy yos i.countryxi : reg lnwage  hours educ lnliteracy yos i.countryxi : reg lnwage  age hours educ lnliteracy yos i.countrylevelsof country, local(levels)foreach l of local levels {display  `l'reg lnwage hours age educ literacy yos if country == `l'}