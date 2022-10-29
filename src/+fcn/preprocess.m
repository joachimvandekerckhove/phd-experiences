function [data, raw_data] = preprocess(rawFileName, processedFileName, forceReload)
%PREPROCESS Summary of this function goes here

if nargin < 3 || ~forceReload
    data = readtable(processedFileName);
    raw_data = readtable(rawFileName);
    return
end

raw_data = fcn.downloadData();
writetable(raw_data, rawFileName)

data = fcn.imputeTimestamps(raw_data);
data = fcn.separateRows(data);
data = fcn.resolveDuplicates(data);

data = removevars(data, ...
    [ "record_id"   ...
      "Duplicate_1" ...
      "Duplicate_2" ...
      "Duplicate_3" ...
      "redcap_survey_identifier" ]);

data = fcn.generateIV(data);
data = fcn.recodeEpoch(data);

data(isnan(data.IV),:) = [];

data = sortrows(data, ["IV" "Epoch" "Person"]);

writetable(data, processedFileName)

end

