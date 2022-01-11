function update_rendered_GT(src, ~)

    main_window = src.Parent;
   
    radiobutton_group = findall(main_window.Children,'Tag','current gt radiobutton');
    GT_index = find(flipud(vertcat(radiobutton_group.Children.Value)));
    
    setappdata(main_window,'GT_index',GT_index);
    
    render_existing_ground_truths(main_window);
    
end