function dicos_dir = populate_study_UID(dicos_dir)

    for file_ind = 1:length(dicos_dir)
        
        file_dicominfo = dicominfo(fullfile(dicos_dir(file_ind).folder,dicos_dir(file_ind).name));
        dicos_dir(file_ind).StudyInstanceUID = categorical(string(file_dicominfo.StudyInstanceUID));
        
        disp("Study instance population: " + 100*file_ind/length(dicos_dir) + "%");
    end
    
end
