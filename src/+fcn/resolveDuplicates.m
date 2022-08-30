function data = resolveDuplicates(data)

pList = unique(data.record_id);

data.Person = nan(size(data.record_id));
pCounter = 1000;

for pIdx = 1:numel(pList)
    pCounter = pCounter + 1;

    % Get duplicates
    rows = data(data.record_id == pList(pIdx), :);
    dupes = unique(table2array(rows(:,1:4))); dupes(isnan(dupes)) = [];

    % Tag relevant rows
    theseRows = ismember(data.record_id, dupes);
    data.Person(theseRows) = pCounter;
    data.record_id(theseRows) = nan;

    % Delete relevant rows
end

end