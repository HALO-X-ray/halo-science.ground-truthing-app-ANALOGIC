function update_axes_images(main_window)

    hxt_scan_keys = getappdata(main_window,'hxt_scan_keys');
    hxt_dir = getappdata(main_window,'hxt_dir');
    hxt_dir(contains({hxt_dir.name},'.de')) = [];
    hxt_filenames = string(fullfile({hxt_dir.folder},{hxt_dir.name}));
    dx_dir = getappdata(main_window,'dx_dir');    

    counter = findall(main_window.Children,'Tag','index_counter');

    v1_axis = findall(main_window.Children,'Tag','v1_axis');
    delete(v1_axis.Children);
    v2_axis = findall(main_window.Children,'Tag','v2_axis');
    delete(v2_axis.Children);

    hxt_scan_key_ind = counter.Value;
    
    hxt_scan_key = hxt_scan_keys(hxt_scan_key_ind);
    
    [dx_files, dx_valid_check] = find_analogic_img_files(hxt_filenames(hxt_scan_key_ind), dx_dir);
    
        
    if dx_valid_check
        
        setappdata(main_window,'v1_image',dx_files(1).colour_zeff);
        setappdata(main_window,'v2_image',dx_files(2).colour_zeff);
        
        imshow(dx_files(1).colour_zeff,'Parent',v1_axis);
        xlim(v1_axis,[1 size(dx_files(1).colour_zeff,2)]);
        ylim(v1_axis,[1 size(dx_files(1).colour_zeff,1)]);
        
        imshow(dx_files(2).colour_zeff,'Parent',v2_axis);
        xlim(v2_axis,[1 size(dx_files(2).colour_zeff,2)]);
        ylim(v2_axis,[1 size(dx_files(2).colour_zeff,1)]);
        
    else
        
        placeholder = ones(600);
        
        cla(v1_axis); cla(v2_axis);
        imshow(placeholder,'Parent',v1_axis);
        text(v1_axis,250,250,"File Not Found");
        xlim(v1_axis,[0 600]);
        ylim(v1_axis,[0 600]);
        imshow(placeholder,'Parent',v2_axis);
        text(v2_axis,250,250,"File Not Found");
        xlim(v2_axis,[0 600]);
        ylim(v2_axis,[0 600]);   
        
        
    end


end
