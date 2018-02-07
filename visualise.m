function result = visualise(file_path, type, time_window)

% Usage visualize('/data/csv/', 'accelerometer', 24)
%
% This will give daily plots for the csv data
% If time_window is 0 then all the data is plotted.
%
% Created by Yatharth Ranjan on 05/02/2018

% Edit these according to the data that is read.
switch(type)
    case  'accelerometer'
        columns_to_read = {'value_time','value_x','value_y','value_z'};
        data_column_name = 'value_x';
        y_label = 'x-axis_Accelerometer';
        y_lim = [-10 10]
    case 'battery'
        columns_to_read = {'value_time','value_batteryLevel'};
        data_column_name = 'value_batteryLevel';
        y_label = 'Battery Level';
        y_lim = [0 1]
    case 'gyroscope'
        columns_to_read = {'value_time','value_x','value_y','value_z'};
        data_column_name = 'value_x';
        y_label = 'x-axis_Gyroscope';
        y_lim = [-10 10]
    case 'step_count'
        columns_to_read = {'value_time', 'value_steps'};
        data_column_name = 'value_steps';
        y_label = 'Number of steps';
        y_lim = []
    otherwise
end

switch(time_window)
    case 0
        T = plot_all_data(file_path, columns_to_read, data_column_name, y_label);
        
    case 24
        daily_plots(file_path, columns_to_read, data_column_name, y_label, y_lim);
        
    otherwise
        T = combine_csv_table_data(file_path, time_window, columns_to_read, data_column_name, y_label);
end
end