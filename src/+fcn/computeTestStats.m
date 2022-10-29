function [results, condition] = computeTestStats(indicator, stats, globalLlik, ...
    alpha)

[condLlik, df] = fcn.conditionalLikelihood(stats, indicator);

logLR = condLlik.classical - globalLlik.classical;
p  = 1 - chi2cdf(2 * logLR, df);
h  = p < alpha;

results = table( nan, nan, nan, nan, ...
    'VariableNames', ["logLR" "df" "p" "h"]);
results(1, ["logLR" "df" "p" "h"]) = { logLR df p h };

condition = ~h;

end