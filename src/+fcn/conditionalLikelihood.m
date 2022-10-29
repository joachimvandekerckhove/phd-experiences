function [condLlik, df] = conditionalLikelihood(stats, indicator)

[condLlik.classical, df] = classical(stats, indicator);

end


function [condLlik, df] = classical(stats, indicator)

condLlik = 0;
indicatorVector = table2array(stats.subset(:, indicator));

for g = unique(indicatorVector)'
    thisDV = stats.subset.DV(indicatorVector == g);
    condPars = [mean(thisDV), std(thisDV)];
    condLlik = condLlik - normlike(condPars, thisDV);
end

df = 2 * numel(unique(indicatorVector)) - 2;

end

