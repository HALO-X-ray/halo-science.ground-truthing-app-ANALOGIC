function generate_new_rectangle(main_window)
    
    v1_axis = findall(main_window.Children,'Tag','v1_axis');
    v2_axis = findall(main_window.Children,'Tag','v2_axis');

    v1_current_roi = drawrectangle(v1_axis);
%     v2_current_roi = drawrectangle(v2_axis); 
    
    setappdata(main_window, 'v1_gt_tmp', v1_current_roi);
%     setappdata(main_window, 'v2_gt_tmp', v2_current_roi);
    
    
end