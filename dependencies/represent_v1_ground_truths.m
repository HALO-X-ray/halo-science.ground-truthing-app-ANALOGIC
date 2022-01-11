function represent_v1_ground_truths(main_window, v1_gt_exists, v1_gt)
    if any(v1_gt_exists)

        v1_axis = findall(main_window.Children,'Tag','v1_axis');
        hold(v1_axis,'on');
        v2_axis = findall(main_window.Children,'Tag','v2_axis');
        hold(v2_axis,'on');
        previous_lines = findall(v2_axis.Children,'type','Line');
        delete(previous_lines);
        v2_line_coords = v2_axis.YLim;
      
        highlighted_index = getappdata(main_window,'GT_index');
        
        for gt_index = 1:size(v1_gt,1)
            if ~isempty(v1_gt{gt_index})
            
                if gt_index == highlighted_index
                    alpha = 1;
                    line_alpha = 1;
                else
                    alpha = 0.4;
                    line_alpha = 0.05;
                end
                
                rectangle(v1_axis,'Position',v1_gt{gt_index},'EdgeColor',alpha.*[1 0 0],'LineWidth',1.0);
                text(v1_axis,v1_gt{gt_index}(1), v1_gt{gt_index}(2), string(gt_index), 'Color', [1 0 0]);
                
                plot([1 1]*v1_gt{gt_index}(1),v2_line_coords,'linestyle','--','Color',line_alpha*[0.8 0.2 0.2 0.6],'Parent',v2_axis);
                plot([1 1]*(v1_gt{gt_index}(1) + v1_gt{gt_index}(3)),v2_line_coords,'linestyle','--','Color',line_alpha*[0.8 0.2 0.2 0.4],'Parent',v2_axis);        

            
            end
        end
        
    end
end