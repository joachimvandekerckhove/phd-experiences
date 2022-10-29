function [h, stats] = plotDv(data, thisDv, hAx)
%PLOTDV Summary of this function goes here

stats = fcn.getStats(data, thisDv);

axes(hAx)

e = .05;
xax = repmat(1:3,3,1) + repmat([-1 0 1]'*e,1,3);

h = errorbar(xax',stats.mn', stats.lo', stats.hi', 'o-');

xlim([.75 3.25])
title(thisDv, 'Interpreter', 'none')
xlabel epoch
set(gca, 'XTick', 1:3)

legend 'Group 1' 'Group 2' 'Group 3' 'Location' 'best'

exportgraphics(gcf, sprintf('figures/%s.pdf', thisDv))

end
