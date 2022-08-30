

%% Load and process data

raw_data = fcn.loadData();
writetable(data, 'data/raw.csv')

raw_data = fcn.imputeTimestamps(raw_data);

data = fcn.separateRows(raw_data);
data = fcn.resolveDuplicates(data);
data = removevars(data, ["record_id" "Duplicate_1" "Duplicate_2" "Duplicate_3" ...
    "redcap_survey_identifier"]);

data = fcn.generateIV(data);
data = fcn.recodeEpoch(data);

data(isnan(data.IV),:) = [];

data = sortrows(data, ["IV" "Epoch" "Person"]);

writetable(data, 'data/processed.csv')

%%

dvList = ["advanced" ...
    "milestones_cogsci" "milestones_psysci" "enjoy" ...
    "good" "nonexperts" "discouraged" "writers_block" ...
    "inspired" "cant_start" "rejection" "rcv_fdbk" ...
    "gv_fdbk" "timeblock" "hours" ...
    "conference_submit" "conference_accept" "perma_hap"];
% dvList =  "advanced"
ctr = 0;
e = .05;
xax = repmat(1:3,3,1) + repmat([-1 0 1]'*e,1,3);
for dvIdx = dvList
    subset = data;
    rm = isnan(data.(dvIdx));
    subset(rm,:) = [];
    dv = subset.(dvIdx);
    if all(ismember(dv, 0:1))
        for t = 1:3
            for g = 1:3
                sub = dv(subset.IV==g & subset.Epoch==t & ~isnan(dv));
                sc(g,t) = sum( sub);
                fl(g,t) = sum(~sub);
            end
        end
        mn = betainv(.500*ones(3), sc, fl);
        lo = mn - betainv(.025*ones(3), sc, fl);
        hi = betainv(.975*ones(3), sc, fl) - mn;
    else
        for t = 1:3
            for g = 1:3
                mn(g,t) = mean(dv(subset.IV==g & subset.Epoch==t), 'omitnan');
                sd(g,t) = std(dv(subset.IV==g & subset.Epoch==t), 'omitnan');
            end
        end
        lo = 1.96 * sd;
        hi = 1.96 * sd;
    end
    ctr = ctr + 1;
    subplot(4,5,ctr)
    errorbar(xax', mn', lo', hi', 'o-')
    xlim([.75 3.25])
    title(dvIdx)
    xlabel epoch
    set(gca, 'XTick', 1:3)
end
legend 'Group 1' 'Group 2' 'Group 3'

