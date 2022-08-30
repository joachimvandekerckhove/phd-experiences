function raw_data = imputeTimestamps(raw_data)

dummy_date = datetime('01-Jan-0000');      % empty datetimes are this sometimes

current    = datetime('28-Sep-0021 0:00'); % datetime tracker

for r = 1:numel(raw_data.record_id) % loop over records

    date_is_dummy   = raw_data.student_survey_timestamp(r) == dummy_date;
    date_is_nat     = isnat(raw_data.student_survey_timestamp(r));
    needs_replacing = date_is_dummy || date_is_nat;
    
    if needs_replacing
        % if there is no date, assume previous date still holds
        raw_data.student_survey_timestamp(r) = current;
    else
        % if there is a date, keep it and update tracker
        current = raw_data.student_survey_timestamp(r);
    end

end

current    = datetime('21-Jun-0022 0:00');

for r = 1:numel(raw_data.record_id) % loop over records

    date_is_dummy   = raw_data.student_survey_new_participant_timestamp(r) == dummy_date;
    date_is_nat     = isnat(raw_data.student_survey_new_participant_timestamp(r));
    needs_replacing = date_is_dummy || date_is_nat;
    
    if needs_replacing
        % if there is no date, assume previous date still holds
        raw_data.student_survey_new_participant_timestamp(r) = current;
    else
        % if there is a date, keep it and update tracker
        current = raw_data.student_survey_new_participant_timestamp(r);
    end

end
end