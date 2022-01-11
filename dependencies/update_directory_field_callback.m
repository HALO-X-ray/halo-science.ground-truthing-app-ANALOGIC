function update_directory_field_callback(src,event)

    main_window = src.Parent;
    new_directory = event.Value;
    
    if exist(new_directory,'dir') == 7
        
        update_data_directory(main_window,new_directory);
        
    else
        
        wrong_directory_label = findall(main_window.Children,'Tag','wrong directory label');
     
        wrong_directory_label.Visible = 'on';

        pause(1.2);
        
        wrong_directory_label.Visible = 'off';
        
        src.Value = event.PreviousValue;
        
    end

    figure(main_window);

end