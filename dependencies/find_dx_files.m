function [dx_files, valid] = find_dx_files(hxt_scan_key, dx_dir)

    dx_filenames = string({dx_dir.name});
    dx_files = dx_dir(contains(dx_filenames,hxt_scan_key));

    valid = length(dx_files) == 2;

    if valid
        for dx_file_ind = 1:length(dx_files)

            dx_files(dx_file_ind).zeff = dicomread(fullfile(dx_files(dx_file_ind).folder,dx_files(dx_file_ind).name));

        end
        
        dx_files = colour_zeff(dx_files);

    end
     

end
