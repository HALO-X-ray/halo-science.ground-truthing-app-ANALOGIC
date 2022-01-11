function refresh_display(main_window)
    
    render_gt_radiobuttons(main_window)
    update_scan_key_label(main_window);
    update_timestamp_label(main_window);
    update_axes_images(main_window);
    render_existing_ground_truths(main_window);
    update_validity_checkbox(main_window);
    update_dataset_progress(main_window);

end