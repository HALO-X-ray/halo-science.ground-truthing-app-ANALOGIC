function update_scan_key_label(main_window)

    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');

    counter = findall(main_window.Children,'Tag','index_counter');
    scan_key_label = findall(main_window.Children,'Tag','scan_key_label');
    
    scan_key_label.Text = "Scan Key: " + hxt_scan_keys(counter.Value);

end