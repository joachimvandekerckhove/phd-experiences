function stats = getStatsForReal(dv, subset)

stats.mn = zeros(3,3);
stats.sd = zeros(3,3);

for t = 1:3
    for g = 1:3
        thisDv = dv(subset.IV==g & subset.Epoch==t & ~isnan(dv));
        if numel(thisDv)
            stats.mn(g,t) = mean(thisDv);
            stats.sd(g,t) = std(thisDv);
        else
            stats.mn(g,t) = nan;
            stats.sd(g,t) = nan;
        end
    end
end

stats.lo = 1.96 * stats.sd;
stats.hi = 1.96 * stats.sd;

end