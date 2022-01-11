function update_previous_v2_gt_label(main_window, gt_exists, gt)

    gt_label = findall(main_window.Children,'Tag','current_v2_gt_label');
    
    if gt_exists
        
        gt_label.Text = "Current v2 ground truth: [" + join(string(gt{:}),',') + "]";
        
    else
       
        gt_label.Text = 'Current v2 ground truth: None Found';

    end
    



end