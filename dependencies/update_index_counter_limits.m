function update_index_counter_limits(main_window,tdr_number)

    index_counter = findall(main_window.Children,'Tag','index_counter');
    index_counter.Limits = [1 tdr_number];

end