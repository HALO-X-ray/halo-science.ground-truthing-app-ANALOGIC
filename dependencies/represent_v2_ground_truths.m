function represent_v2_ground_truths(main_window, v2_gt_exists, v2_gt)
    if any(v2_gt_exists)

        v1_axis = findall(main_window.Children,'Tag','v1_axis');
        hold(v1_axis,'on');
        previous_lines = findall(v1_axis.Children,'type','Line');
        delete(previous_lines);
        v1_line_coords = v1_axis.YLim;
        v2_axis = findall(main_window.Children,'Tag','v2_axis');
        hold(v2_axis,'on');
       
        highlighted_index = getappdata(main_window,'GT_index');
        
        for gt_index = 1:size(v2_gt,1)
            if ~isempty(v2_gt{gt_index})
            
                if gt_index == highlighted_index
                    alpha = 1;
                    line_alpha = 1;

                else
                    alpha = 0.4;
                    line_alpha = 0.05;
                end

                rectangle(v2_axis,'Position',v2_gt{gt_index},'EdgeColor',alpha.*[1 0 0],'LineWidth',1.0);
                text(v2_axis,v2_gt{gt_index}(1), v2_gt{gt_index}(2), string(gt_index), 'Color', [1 0 0]);

                plot([1 1]*v2_gt{gt_index}(1),v1_line_coords,'linestyle','--','Color',line_alpha*[0.8 0.2 0.2 0.6],'Parent',v1_axis);
                plot([1 1]*(v2_gt{gt_index}(1) + v2_gt{gt_index}(3)),v1_line_coords,'linestyle','--','Color',line_alpha*[0.8 0.2 0.2 0.4],'Parent',v1_axis);        

            
            end
        end
        
    end
end