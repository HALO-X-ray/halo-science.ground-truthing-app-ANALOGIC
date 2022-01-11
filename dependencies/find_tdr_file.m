function [tdr_file, DICOM_metadata, valid] = find_tdr_file(hxt_scan_key, tdr_dir)

    tdr_filenames = string({tdr_dir.name});
    
    tdr_file = tdr_dir(contains(tdr_filenames,hxt_scan_key));

    DICOM_metadata = dicominfo(fullfile(tdr_file.folder,tdr_file.name));

    valid = length(tdr_file) == 1;
end
