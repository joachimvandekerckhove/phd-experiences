function outputArg = globalLikelihood(stats)
%GLOBALLIKELIHOOD Summary of this function goes here
%   Detailed explanation goes here

sumStats = [mean(stats.subset.DV) std(stats.subset.DV)];

outputArg.classical = -normlike(sumStats, stats.subset.DV);

ll = @(m,s)prod(normpdf((stats.subset.DV-m)/s));
pm = @(m)  stats.priors.mean(m);
ps = @(s)  stats.priors.std(s);

outputArg.bayesian  = log( ...
    integral( ...
    @(s)integral( ...
    @(m)ll(m,s) * pm(m), ...
    -5, 5) * ps(s), ...
    0, 5) );

end

