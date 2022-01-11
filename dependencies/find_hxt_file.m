function [hxt_file, valid] = find_hxt_file(hxt_scan_key, hxt_dir)

    hxt_filenames = string({hxt_dir.name});
    hxt_file = hxt_dir(contains(hxt_filenames,hxt_scan_key));
    
    raw_data = load_hxt(fullfile(hxt_file.folder, hxt_file.name),'raster');
    datacube = pix2raster_xye_heros(raw_data, 500, 700); datacube = datacube(:,:,1:180);
    
    hxt_file.datacube = datacube;    
    
    valid = length(hxt_file) == 1;

end