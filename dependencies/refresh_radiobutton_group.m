function bg = refresh_radiobutton_group(main_window)

    bg = findall(main_window.Children,'Tag','current gt radiobutton');
    delete(bg);
    uibuttongroup(main_window,'Position',nonnormalised_size(main_window, [0.025 0.16 0.09 0.5]),...
        'Tag','current gt radiobutton',...
        'Visible','on',...
        'scrollable','on',...
        'Title','Selected Ground Truth',...
        'SelectionChangedFcn',@update_rendered_GT);
    bg = findall(main_window.Children,'Tag','current gt radiobutton');
    setappdata(main_window,'GT_index',1);

end