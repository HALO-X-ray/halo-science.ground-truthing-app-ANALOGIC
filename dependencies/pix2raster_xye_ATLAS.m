function [raster, counts]= pix2raster_xye_ATLAS(data)
    
    S = [size(1:max(data(:,1)),2), size(1:max(data(:,3)),2), 180];
    raster = zeros(S(1), S(2), S(3));
    counts = zeros(S(1),S(2));
    
    for i=1:length(data)
        
        xi = data(i,1);
        yi = data(i,3);
        ei = data(i,5);
        raster(xi,yi,ei)=raster(xi,yi,ei) + data(i,6);
        counts(xi,yi)= counts(xi,yi) + data(i,6);
        
    end
    
end