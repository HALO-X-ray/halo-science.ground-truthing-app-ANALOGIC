function [tdr_dir, hxt_dir, image_dir, hxt_scan_keys, timestamps, tdr_number, ground_truth_table] = ...
    initialise_variables_from_analogic_directory(data_directory)
%%
    tdr_dir = dir(fullfile(data_directory,"*.tdr.dcs"));
    hxt_dir = dir(fullfile(data_directory,"*.hxt"));
    image_dir = dir(fullfile(data_directory,"\analogic-files\*.dicos-ct.dcs"));

    for image_ind = 1:length(image_dir)
       
        image_dir(image_ind).metadata = dicominfo(fullfile(image_dir(image_ind).folder,image_dir(image_ind).name),'UseDictionaryVR',true);
        image_dir(image_ind).ID = string(image_dir(image_ind).metadata.PatientID);
        
    end
    
    disp("Analogic Directory Loaded");
    
    hxt_scan_keys = reduce_filename_to_identifier(string({tdr_dir.name}));
    timestamps = reduce_filename_to_timestamps(string({tdr_dir.name}));
    tdr_number = length(tdr_dir);
    
    hxt_scan_keys_2 = cellstr(hxt_scan_keys);
    [tdr_dir.ID] = deal(hxt_scan_keys_2{:});
    

    ground_truth_table = load_initial_ground_truth_table(data_directory);

    scan_valid_field_exists = ismember("is_valid_scan",ground_truth_table.Properties.VariableNames);
    gt_index_field_exists = ismember("GT_index",ground_truth_table.Properties.VariableNames);
    
    if ~scan_valid_field_exists
        ground_truth_table.is_valid_scan = true(size(ground_truth_table,1),1);
    end
    if ~gt_index_field_exists
        [~,ground_truth_table.GT_index] = unique(ground_truth_table.scan_key);
    end    

end
