function Size = nonnormalised_size(Main_Window, Normalized_Position)
    
    Main_Position = Main_Window.Position;
    Size = round(Main_Position([3,4,3,4]) .* Normalized_Position);

end
