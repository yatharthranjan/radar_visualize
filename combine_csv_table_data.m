function combined = combine_csv_table_data(folder_path, time_window, columns_to_read, data_column, y_label)
% Created by Yatharth Ranjan on 05/02/2018
%% Process only sepcified number of files at a time
csv_files = dir(strcat(folder_path, '/*.csv'))
num_files = length(csv_files)
loop = num_files/time_window;
kk = 1;
for ii = 1:loop
    
    % Add Folder path to file names to create valid path for each csv file
    % in the time window
    values = cellfun(@(c)[folder_path '/' c],{csv_files(kk:kk+time_window-1).name},'uni',false);
    ds =  tabularTextDatastore(values, 'FileExtensions', '.csv');
    if (kk < num_files)
        kk = kk + time_window - 1;
    else
        kk = num_files;
    end
    ds.SelectedVariableNames = columns_to_read;
    T = readall(ds);

    ts = timeseries(T{:,{data_column}}, T{:,{'value_time'}});
    plot_and_save(ts, 'Time', y_label, ii, '-dpng', 'MDD Visualize/plots')
end
combined = T;
end
