function daily_plots(folder_path, columns_to_read, data_column_name, y_label, y_lim)
% Function for reading CSV files from a Folder and creating a plot for
% daily data. A single file contains data of one hour for a particular 
% sensor and is named in the format yyyyMMdd_HHmm.csv
%
% function daily_plots(folder_path, columns_to_read)
% Input
%   folder_path - is the path containing the CSV files
%   
%   columns_to_read - is the name of the columns to read from the CSV files. 
%       This is a cell array containing all the column names.
% 
% Output
%   A number of figures containing daily plots for the data
%   The figures are also saved in the current folder as pdf files

% Created by Yatharth Ranjan on 05/02/2018

%% Get File list in the folder and intialize variables

% List the csv files in the specified folder
file_list = dir(strcat(folder_path, '/*.csv'))

% Initialize variables required for plotting
paths = {};
figure_num = 1;
plot_num = 1;
k =1;

% Change this to modify the number of plots in each figure
max_plots_in_figure = 5;

% Get the first date
current_date = strsplit(file_list(1).name , '_') ;

%% Iterate through each file and plot all the data date-wise
for i= 1:length(file_list)
   date_time = strsplit(file_list(i).name , '_');
   % Keep adding the paths of the files with the same date
   if (strcmp(date_time(1), current_date(1)) && i<length(file_list))
       path = strcat(folder_path, strcat('/', file_list(i).name));
       paths(k) = {path};
       k = k + 1;
   % If the date is different from previous value that means 
   % we have collected all the files for a single day in the paths variable.
    % Read all those files and create a time series and plot the data.
   else
       ds =  tabularTextDatastore(paths, 'FileExtensions', '.csv');
       % Select which columns to read from the csv data  store
       ds.SelectedVariableNames = columns_to_read;
       % Read all the csv data into a single table
        T = readall(ds);
        % Create a time-series object from the tabular data
        ts = timeseries(T{:,{data_column_name}}, T{:,{'value_time'}});
       
        figure(figure_num)
        
        % plots max_plots_in_figure number of plots in a single figure
        % Creates a new figure if plots are more than this value. Currently
        % set to 5
        subplot(max_plots_in_figure, 1, plot_num);
        plot(datetime(ts.Time, 'convertfrom','posixtime'), ts.Data)
        xlabel('Time')
        ylabel(y_label)
        date_string = datestr(datetime(current_date(1), 'InputFormat', 'yyyyMMdd'));
        [~, day] = weekday(date_string);
        title(strcat(date_string, strcat(',', day)))
        % Set uniform X-limits from 00:00 to 23:59 and Y-limits for each daily plot
        xlim([datetime(strcat(current_date(1), '00:00'), 'InputFormat', 'yyyyMMddHH:mm') 
            datetime(strcat(current_date(1),'23:59'), 'InputFormat', 'yyyyMMddHH:mm')])
        ylim(y_lim)
       current_date(1) = date_time(1);
       paths = {};
       k = 1;
       plot_num = plot_num + 1;
       % Create a new figure if this one has max number of plots
       if(plot_num > max_plots_in_figure || i == length(file_list))
           % Save the file with name AccelerometerDaily_id44-*.png in the
           % current folder. Edit the name according to your data type
          print('-r500', strcat(sprintf('%sDaily-', y_label), num2str(figure_num)), '-dpdf', '-fillpage')
          figure_num = figure_num + 1;
          plot_num = 1;
       end
   end
end
end