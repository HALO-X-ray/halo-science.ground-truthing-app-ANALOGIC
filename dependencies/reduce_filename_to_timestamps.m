function timestamps = reduce_filename_to_timestamps(filenames)

    timestamps = strings(size(filenames));
    
    for filename_ind = 1:length(filenames)
        
       split_filename = split(filenames(filename_ind),'-'); 
       filename = join(split_filename(1:5),'-');
       
       split_filename = split(filename,'_');
       
       date = split_filename(1);
       time = strrep(split_filename(2),'-',':');
       
       timestamps(filename_ind) = date + "_" + time;
        
    end

end
