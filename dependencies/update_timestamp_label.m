function update_timestamp_label(main_window)

    timestamps = getappdata(main_window,'timestamps');

    counter = findall(main_window.Children,'Tag','index_counter');
    timestamp_label = findall(main_window.Children,'Tag','scan_timestamp');
    
    timestamp_label.Text = "Scan Timestamp: " + timestamps(counter.Value);

end