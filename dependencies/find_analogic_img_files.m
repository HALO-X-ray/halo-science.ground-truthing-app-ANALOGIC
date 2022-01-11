function [img_files, valid] = find_analogic_img_files(hxt_filename, img_dir)

    image_IDs = string({img_dir.ID});
    tdr_filename = strrep(hxt_filename,".hxt",".tdr.dcs");
    tdr_dicominfo = dicominfo(tdr_filename,'UseDictionaryVR',true);
    tdr_ID = tdr_dicominfo.PatientID;
    
    img_files = img_dir(image_IDs == tdr_ID);

    valid = length(img_files) == 2;

    if valid
        for dx_file_ind = 1:length(img_files)

            img_files(dx_file_ind).zeff = dicomread(fullfile(img_files(dx_file_ind).folder,img_files(dx_file_ind).name));
            
            img_files(dx_file_ind).zeff = double(rot90(img_files(dx_file_ind).zeff));
            img_files(dx_file_ind).zeff = img_files(dx_file_ind).zeff ./ max(img_files(dx_file_ind).zeff,[],'all');
            
        end
        
        img_files = colour_zeff(img_files);

    end
     

end
