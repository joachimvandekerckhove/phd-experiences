function outputArg = globalLikelihood(stats)

sumStats = [mean(stats.subset.DV) std(stats.subset.DV)];

outputArg.classical = -normlike(sumStats, stats.subset.DV);

end

