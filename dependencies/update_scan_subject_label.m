function update_scan_subject_label(main_window)

    scan_subject_label = findall(main_window.Children,'Tag','scan subject label');
    
    scan_subject_label.Text = "Scan Subject: " + getappdata(main_window,'active_scan_subject');


end