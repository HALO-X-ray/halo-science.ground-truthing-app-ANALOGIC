function backward_button_callback(src,~)
    
    main_window = src.Parent;
    counter = findall(main_window.Children,'Tag','index_counter');
    
    if counter.Value > 1
        counter.Value = counter.Value - 1;
    end
    
    refresh_display(main_window);
    
end
