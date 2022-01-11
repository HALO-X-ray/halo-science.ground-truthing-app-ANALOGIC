function init_scan_subject_label(main_window)
    
    bg = findall(main_window.Children, 'Tag', 'scan subject button group');
    label = findall(main_window.Children, 'Tag', 'scan subject label');
    
    if ~isempty(bg)
        delete(bg);
    end

    if ~isempty(label)
        delete(label);
    end
    
    scan_subject = getappdata(main_window,'scan_subject');

    number_of_object_classes = length(scan_subject);
    
    if number_of_object_classes == 1

        uilabel(main_window,'Position',nonnormalised_size(main_window, [0.025 0.77 0.3 0.04]),'Text',"Scan Subject: " + getappdata(main_window,'scan_subject'),...
                'Tag','scan subject label');
            
    else
       
        bg = uibuttongroup(main_window,'Position',...
            nonnormalised_size(main_window, [0.025 0.68 0.1 0.11]),...
            'scrollable','on',...
            'Title','Selected Material',...
            'Tag','scan subject button group',...
            'SelectionChangedFcn',@update_subject_callback);
        
        for subject_ind = 1:number_of_object_classes
        
            uiradiobutton(bg,...
                'Position',nonnormalised_size(main_window, [0.01 0.08 - (0.022*subject_ind) 0.07 0.02]),...
                'Text',scan_subject(subject_ind));
        
        end
        
        
    end


end
