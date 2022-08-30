function raw_data = imputeTimestamps(raw_data)

dummy_date = datetime('01-Jan-0000'); % empty datetimes are this sometimes

raw_data   = imputePartial(      ...
    raw_data                   , ...
    'student_survey_timestamp' , ...
    '28-Sep-0021 0:00'           ...
    );

raw_data   = imputePartial(                      ...
    raw_data                                   , ...
    'student_survey_new_participant_timestamp' , ...
    '21-Jun-0022 0:00'                           ...
    );

    function raw_data = imputePartial(raw_data, timestamp_field, current)

        current = datetime(current);

        for r = 1:numel(raw_data.record_id) % loop over records

            date_is_dummy   = raw_data.(timestamp_field)(r) == dummy_date;
            date_is_nat     = isnat(raw_data.(timestamp_field)(r));
            needs_replacing = date_is_dummy || date_is_nat;

            if needs_replacing
                % if there is no date, assume previous date still holds
                raw_data.(timestamp_field)(r) = current;
            else
                % if there is a date, keep it and update tracker
                current = raw_data.(timestamp_field)(r);
            end

        end
    end
end