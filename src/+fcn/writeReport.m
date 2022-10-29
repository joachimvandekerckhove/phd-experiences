function writeReport(dvName, results, fid)

if nargin < 4
    fid = 1;
end

f = @(varargin) fprintf(fid, varargin{:});

f('Dependent variable: "%s"\n', dvName)

if results.Omnib.h(dvName)

    f('We see some effects on "%s".\n', dvName);
    f('The omnibus test was significant (X2[%i] = %.6g, p = %.4g).\n', ...
        results.Omnib.df(dvName), ...
        2 * results.Omnib.logLR(dvName), ...
        results.Omnib.p(dvName));

    if results.Group.h(dvName)
        f('We see an effect of Group on "%s".\n', dvName);
        f('The effect of Group was significant (X2[%i] = %.6g, p = %.4g).\n', ...
            results.Group.df(dvName), ...
            2 * results.Group.logLR(dvName), ...
            results.Group.p(dvName));
    else
        f('We do not see an effect of Group on "%s".\n', dvName);
        f('The test of Group was not significant (X2[%i] = %.6g, p = %.4g).\n', ...
            results.Group.df(dvName), ...
            2 * results.Group.logLR(dvName), ...
            results.Group.p(dvName));
    end

    if results.Epoch.h(dvName)
        f('We see an effect of Epoch on "%s".\n', dvName);
        f('The effect of Epoch was significant (X2[%i] = %.6g, p = %.4g).\n', ...
            results.Epoch.df(dvName), ...
            2 * results.Epoch.logLR(dvName), ...
            results.Epoch.p(dvName));
    else
        f('We do not see an effect of Epoch on "%s".\n', dvName);
        f('The test of Epoch was not significant (X2[%i] = %.6g, p = %.4g).\n', ...
            results.Epoch.df(dvName), ...
            2 * results.Epoch.logLR(dvName), ...
            results.Epoch.p(dvName));
    end

else

    f('We do not see any effects on "%s".\n', dvName);
    f('The omnibus test was not significant (X2[%i] = %.6g, p = %.4g).\n', ...
        results.Omnib.df(dvName), ...
        2 * results.Omnib.logLR(dvName), ...
        results.Omnib.p(dvName));

end

f('\n');

end

