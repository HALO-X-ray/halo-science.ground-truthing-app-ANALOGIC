function render_existing_ground_truths(main_window)

    [v1_gt_exists, v1_gt, v2_gt_exists,  v2_gt] = check_for_existing_gts(main_window);
%     update_previous_v1_gt_label(main_window, v1_gt_exists, v1_gt);
%     update_previous_v2_gt_label(main_window, v2_gt_exists, v2_gt);
%     
    represent_v1_ground_truths(main_window, v1_gt_exists, v1_gt);
    represent_v2_ground_truths(main_window, v2_gt_exists, v2_gt);
    update_gt_labels(main_window);

end