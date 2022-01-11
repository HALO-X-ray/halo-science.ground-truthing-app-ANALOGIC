function dx_files = colour_zeff(dx_files)

%     colour_table = imread("G:\Shared drives\Data_ATLAS\ATLAS\Edge-ATR Live Data\Ground truthing software\dependencies\ColorTable.bmp");

    for dx_file_ind = 1:2
        
%         load("G:\Shared drives\Data\HXT.264 - Build 6\2020-12-14\Build#6\2020-12-14\De_map4.mat",'original_map');
%         colourmap = squeeze(imresize(original_map.map(:,3277,:),[255,1]));
%         colourmap = colourmap - min(colourmap,[],1);
%         colourmap = colourmap/max(colourmap(:));
%         zeff = 255*double(dx_files(dx_file_ind).zeff)/65535;
% %         cmap = squeeze(mean(colour_table,2)/255);
%         
%         imshow(zeff,fliplr(colourmap));%double(squeeze(flipud(colour_table(:,150,:)/255))));

       dx_files(dx_file_ind).colour_zeff = dx_files(dx_file_ind).zeff; 
        
    end

end