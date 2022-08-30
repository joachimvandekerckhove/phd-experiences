function data = recodeEpoch(data)

time0 = '01-Jan-0000' ;
time1 = '31-Oct-0021' ;
time2 = '31-Dec-0021' ;
time3 = '01-Jan-0023' ;

data.Epoch(:) = nan;

data.Epoch(isbetween(data.student_survey_timestamp, time0, time1)) = 1;
data.Epoch(isbetween(data.student_survey_timestamp, time1, time2)) = 2;
data.Epoch(isbetween(data.student_survey_timestamp, time2, time3)) = 3;

end