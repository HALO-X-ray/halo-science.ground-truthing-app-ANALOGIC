function PCA_image = diff2colour_ATLAS(datacube, display)

%load some constants
load("G:\Shared drives\Data_ATLAS\ATLAS\Edge-ATR Live Data\Ground truthing software\dependencies\diff2colour_ATLAS_parameters.mat",'COEFF','MU');

alpha = mat2gray(imresize(sum(datacube,3),[165 200]));

%resize the data and normalise
[size1, size2, size3] = size(datacube);
datacube = imresize3(datacube,[size1./10 size2./10 size3]); %resize the data to make it less noisy
[size1, size2, size3] = size(datacube);
spectra_stack = reshape(datacube,[size1.*size2 size3]);

    for i =1:1:size(spectra_stack,1)

        spectra_stack(i,:) = normalize(spectra_stack(i,:));

    end

scores = (spectra_stack - MU)*COEFF;

PCA_stack = reshape(scores,[size1 size2 3]);

PCA_image = zeros(165,200,3);
PCA_image(:,:,1) = mat2gray(imresize(PCA_stack(:,:,1),[165 200]));
PCA_image(:,:,2) = mat2gray(imresize(PCA_stack(:,:,2),[165 200]));
PCA_image(:,:,3) = mat2gray(imresize(PCA_stack(:,:,3),[165 200]));

    if display

        h = imshow(PCA_image);
        set(h,'AlphaData',alpha);

    end

end