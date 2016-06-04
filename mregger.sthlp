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
{opt mregger} {genotype-disease} {genotype-phenotype} [{it:aweight}] {ifin} 
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt fe:}}Fixed effect standard errors (default is multiplicative)
{p_end}
{synopt :{opt ivw:}}Inverse-variance weighted estimator (default is MR-Egger)
{p_end}
{synopt :{opt re:}}random effects version of the estimators{p_end}
{synopt :{opt recons:}}random intercept in an MR-Egger model{p_end}
{synopt :{opt reslope:}}random slope in an MR-Egger model{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:mregger} performs inverse-variance weighted (IVW) and Mendelian 
randomization Egger (MR-Egger) regression using summary level data 
(i.e. reported genotype-disease and phenotype-disease association estimates 
and their standard errors for individual genotypes).

{pstd}
See Bowden et al. Int J Epi, 2015, for more information.

{pstd}
{genotype-disease} variable containing the genotype-disease association estimates.

{pstd}
{phenotype-disease} variable containing the phenotype-disease association estimates.

{pstd}
For the analytic weights you need to specify the inverse of the 
genotype-disease standard errors squared, i.e. aw=1/(gdse^2).
 
{marker options}{...}
{title:Options}

{phang}
{opt fe} specifies fixed effect standard errors (i.e. variance of residuals) 
constrained to 1 (as in F.E. meta-analysis models). The default is 
to use multiplicative standard errors (i.e. variance of residuals 
unconstrained as in standard linear regression).

{phang}
{opt ivw} specifies IVW model, the default is MR-Egger.

{phang}
{opt re} specifies random effects versions of the models. In the random 
effects output the Ms are the random effects (hence we only estimate their 
variance/covariance).

{phang}
{opt recons} specifies a random intercept in the model. Can be specified with 
{opt reslope}.

{phang}
{opt reslope} specifies a random slope in the model. Can be specified with 
{opt recons}.

{marker examples}{...}
{title:Example 1}

{pstd}Using the data provided by Do et al., Nat Gen, 2013 recreate Bowden et 
al., Gen Epi, 2016, Table 4, LDL-c "All genetic variants" median estimates.{p_end}

{pstd}Setup{p_end}
{phang2}{cmd:. use https://raw.github.com/remlapmot/mrmedian/master/dodata, clear}{p_end}

{pstd}Select observations{p_end}
{phang2}{cmd:. gen byte sel1 = (ldlcp2 < 1e-8)}{p_end}

{pstd}IVW{p_end}
{phang2}{cmd:. mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1, ivw}{p_end}

{pstd}IVW with random effects{p_end}
{phang2}{cmd:. mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1, ivw re}{p_end}

{pstd}MR-Egger{p_end}
{phang2}{cmd:. mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1}{p_end}

{pstd}MR-Egger with fixed effect standard errors{p_end}
{phang2}{cmd:. mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1, fe}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:mregger} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(k)}}number of instruments{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:mregger}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimates{p_end}

{marker references}{...}
{title:References}

{marker bowden}{...}
{phang}
Bowden J, Davey Smith G, Burgess S. 2015. 
Mendelian randomization with invalid instruments: effect estimation and bias 
detection through Egger regression. International Journal of Epidemiology. 
DOI: 10.1093/ije/dyv080
{p_end}

{marker author}
{title:Author}

{phang}Tom Palmer