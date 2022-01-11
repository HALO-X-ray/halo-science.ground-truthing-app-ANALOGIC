function converted_rap_alarm_struct = convert_fields_to_struct(rap_alarm_struct)

    fields = fieldnames(rap_alarm_struct);
    converted_rap_alarm_struct = struct();
    
    for alarm_index = 1:length(fields)
       
        converted_rap_alarm_struct(alarm_index,1).alarm = getfield(rap_alarm_struct,fields{alarm_index});
        
    end

end