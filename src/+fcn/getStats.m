function stats = getStats(data, thisDv, priors)

subset = data;
toRemove = isnan(data.(thisDv));
subset(toRemove,:) = [];

dv = subset.(thisDv);

isBinary = all(ismember(dv, 0:1));

if isBinary
    stats = fcn.getStatsForBinary(dv, subset);
else
    stats = fcn.getStatsForReal(dv, subset);
end

stats.subset = subset(:, ["IV" "Epoch"]);
stats.subset.DV = dv;

stats.subset.Condition = stats.subset.Epoch + 3 * (stats.subset.IV - 1);

if nargin > 2
    stats.priors = priors;
end

end