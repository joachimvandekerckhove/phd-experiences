function stats = getStatsForBinary(dv, subset)

sc = zeros(3,3);
fl = zeros(3,3);
stats.sd = zeros(3,3);

for t = 1:3
    for g = 1:3
        sub = dv(subset.IV==g & subset.Epoch==t & ~isnan(dv));
        sc(g,t) = sum( sub);
        fl(g,t) = sum(~sub);
        stats.sd(g,t) = std(sub);
    end
end

stats.mn = betainv(.500*ones(3), sc, fl);
stats.lo = stats.mn - betainv(.025*ones(3), sc, fl);
stats.hi = betainv(.975*ones(3), sc, fl) - stats.mn;

end