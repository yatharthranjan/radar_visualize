function T = plot_all_data(folder_path, columns_to_read, data_column, y_label)
% Created by Yatharth Ranjan on 05/02/2018

%% Collect and process all the csv files
ds =  tabularTextDatastore(folder_path,'FileExtensions', '.csv');
ds.SelectedVariableNames = columns_to_read;
T = readall(ds);

% Uncomment the following line to save the table with all the data in csv
% format.
% writetable(T,'myData.csv','Delimiter',',')  
   ts = timeseries(T{:,{data_column}}, T{:,{'value_time'}});
   plot_and_save(ts, 'Time', y_label, 1, '-dpng', 'MDD Visualize/plots')
end