function identifiers = reduce_filename_to_identifier(filenames)

    %reduces both hxt and tdr filenames to immediately preceeding
    %identifiers
    
    identifiers = strings(length(filenames),1);
    
    for filename_ind = 1:length(filenames)
     
        split_filename = split(filenames(filename_ind),["_","."]);
        
        identifiers(filename_ind,1) = split_filename(3);
        
    end
    
end
