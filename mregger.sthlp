{smcl}
{* *! version 0.1.0  04jun2016 Tom Palmer}{...}
{viewerjumpto "Syntax" "mregger##syntax"}{...}
{viewerjumpto "Description" "mregger##description"}{...}
{viewerjumpto "Options" "mregger##options"}{...}
{viewerjumpto "Examples" "mregger##examples"}{...}
{viewerjumpto "Stored results" "mregger##results"}{...}
{viewerjumpto "References" "mregger##references"}{...}
{viewerjumpto "Author" "mregger##author"}{...}
{title:Title}

{p 5}
{bf:mregger} {hline 2} Mendelian randomization Egger regression
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{opt mregger} {var:_gd} {var:_gp} [{it:aweight}] {ifin} 
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt fe:}}Fixed effect standard errors (default is multiplicative)
{p_end}
{synopt :{opt gxse(varname)}}variable of genotype-phenotype SEs{p_end}
{synopt:{opt het:erogi}}Display heterogeneity/pleiotropy 
statistics{p_end}
{synopt :{opt ivw:}}Inverse-variance weighted estimator (default is MR-Egger)
{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt:{opt noresc:ale}}Do not rescale residual variance to be 1 (if less than 1){p_end}
{synopt :{opt penw:eighted}}Use penalized weights{p_end}
{synopt :{opt re:}}random effects version of the estimators{p_end}
{synopt :{opt recons:}}random intercept in an MR-Egger model{p_end}
{synopt :{opt reslope:}}random slope in an MR-Egger model{p_end}
{synopt:{opt tdist:}}Use t-distribution for Wald test and CI limits{p_end}
{synopt :{opt *:}}extra options passed to {cmd:gsem} for random effects 
estimation{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:mregger} performs inverse-variance weighted (IVW) and Mendelian 
randomization Egger (MR-Egger) regression using summary level data 
(i.e. reported genotype-disease and phenotype-disease association estimates 
and their standard errors for individual genotypes).

{pstd}
See {browse "http://dx.doi.org/10.1093/ije/dyv080":Bowden et al., Int J Epi, 2015}
, for more information.

{pstd}
{var:_gd} variable containing the genotype-disease association estimates.

{pstd}
{var:_gp} variable containing the genotype-phenotype association estimates.

{pstd}
For the analytic weights you need to specify the inverse of the 
genotype-disease standard errors squared, i.e. aw=1/(gdse^2).
 
{marker options}{...}
{title:Options}

{phang}
{opt fe} specifies fixed effect standard errors (i.e. variance of residuals 
constrained to 1 as in fixed effect meta-analysis models). The default is 
to use multiplicative standard errors (i.e. variance of residuals 
unconstrained as in standard linear regression), see Thompson and Sharp 
 (1999) for further details. We recommend specifying this option when using an allelic score as the instrumental variable.

{phang}
{opt gxse(varname)} specifies the variable containing the genotype-phenotype 
association standard errors. These are required for calculating the I^2_GX
statistic (Bowden et al., 2016). An I^2_GX statistic of 90% means that the 
likely bias due measurement error in the MR-Egger slope estimate is around 
10%. If I^2_GX values are less than 90% estimates should be treated with 
caution.
 
{phang}
{opt het:erogi} suppresses display of heterogeneity/pleiotropy 
statistics. In the heterogeneity output 
the model based Q-statistic is reported by multiplying the variance of the 
residuals by the degrees of freedom (Del Greco et al., 2015).
 
{phang}
{opt ivw} specifies IVW model, the default is MR-Egger.

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{phang}
{opt noresc:ale} specifies that the residual variance is not set to 1 (if 
it is found to be less than 1). Bowden et al. (2016) rescale the residual
 variance to be 1 if it is found to be less than 1.

{phang}
{opt penw:eighted} specifies using penalized weights as described in Burgess 
et al. (2016).
 
{phang}
{opt re} specifies random effects versions of the models. In the random 
effects output the Ms are the random effects (hence we only estimate their 
variance/covariance). If only {opt re} is specificed by default both the 
slope and intercept are included as random effects. Requires Stata version 13
or higher (as this uses {cmd:gsem}).

{phang}
{opt recons} specifies a random intercept in the model. Can be specified with 
{opt reslope}. Not allowed with {opt ivw} (as there is no constant in the 
model).

{phang}
{opt reslope} specifies a random slope in the model. Can be specified with 
{opt recons}.

{phang}
{opt tdist} specifies using the t-distribution, instead of the normal 
distribution, for calculating the Wald test and the confidence interval limits.

{phang}
{opt *} extra options passed through to the {cmd:gsem} command, 
see {help gsem_command:gsem}.

{marker examples}{...}
{title:Example 1}

{pstd}Using the data provided by Do et al., Nat Gen, 2013 recreate Bowden et 
al., Gen Epi, 2016, Table 4, LDL-c "All genetic variants" estimates.{p_end}

{pstd}Setup{p_end}
{phang2}{cmd:.} {stata "use https://raw.github.com/remlapmot/mrmedian/master/dodata, clear"}{p_end}

{pstd}Select observations ({it:p}-value with exposure < 10^-8){p_end}
{phang2}{cmd:.} {stata "gen byte sel1 = (ldlcp2 < 1e-8)"}{p_end}

{pstd}IVW{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, ivw"}{p_end}

{pstd}MR-Egger{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1"}{p_end}

{pstd}MR-Egger with fixed effect standard errors{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, fe"}{p_end}

{pstd}MR-Egger reporting {it:I^2_GX} statistic{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, gxse(ldlcse)"}{p_end}

{pstd}MR-Egger with fixed effect standard errors and t-distribution 
CI limits{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, fe tdist"}{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:mregger} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom (with {cmd:tdist} 
option){p_end}
{synopt:{cmd:e(k)}}number of instruments{p_end}
{synopt:{cmd:e(I2GX)}}I^2_GX (with {cmd:gxse()} option){p_end}

{synoptset 20 tabbed}{...}
    If {opt re} is not specified:
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:mregger}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimates{p_end}

{pstd}
If {opt re} is specified {cmd:mregger} additionally returns the e-class 
results from {cmd:gsem}.

{pstd}
If {opt heterogi} is specified {cmd:mregger} 
additionally returns the r-class results of {cmd:heterogi} in the e-class 
results.

{marker references}{...}
{title:References}

{marker bowden}{...}
{phang}
Bowden J, Davey Smith G, Burgess S. 2015. 
Mendelian randomization with invalid instruments: effect estimation and bias 
detection through Egger regression. International Journal of Epidemiology. 
{browse "http://dx.doi.org/10.1093/ije/dyv080":DOI}
{p_end}

{phang}
Bowden J, Davey Smith G, Haycock PC, Burgess S. 2016. Consistent estimation 
in Mendelian randomization with some invalid instruments using a weighted 
median estimator. Genetic Epidemiology, published online 7 April.
{browse "http://dx.doi.org/10.1002/gepi.21965":DOI}

{phang}
Bowden J, Del Greco F, Minelli C, Davey Smith G, Sheehan NA, Thompson JR. 2016. Assessing the suitability of summary data for two-sample Mendelian randomization analyses using MR-Egger regression: the role of the I-squared statistic. 
International Journal of Epidemiology. {browse "http://dx.doi.org/10.1093/ije/dyw220":DOI}

{phang}
Burgess S, Bowden J, Dudbridge F, Thompson SG. 2016. Robust instrumental 
variable methods using candidate instruments with application to Mendelian 
randomization. arXiv:1606.03729v1. 
{browse "https://arxiv.org/abs/1606.03729":Link}

{phang}
Del Greco F M, Minelli C, Sheehan NA, Thompson JR. 2015. Detecting pleiotropy in 
Mendelian randomization studies with summary data and a continuous outcome. 
Statistics in Medicine, 34, 21, 2926-2940. 
{browse "http://dx.doi.org/10.1002/sim.6522":DOI}
{p_end}

{phang}
Thompson SG, Sharp SJ. 1999. Explaining heterogeneity in meta-analysis: a 
comparison of methods. Statistics in Medicine, 18, 20, 2693-2708. 
{browse "http://dx.doi.org/10.1002/(SICI)1097-0258(19991030)18:20<2693::AID-SIM235>3.0.CO;2-V":DOI}
{p_end}

{marker author}
{title:Author}

{phang}Tom Palmer
