function plot_and_save(ts, x_label, y_label, ii, output_type, output_dir)
% Created by Yatharth Ranjan on 05/02/2018
if ii == 1
    cd(output_dir)
end
figure(ii), plot(datetime(ts.Time, 'convertfrom','posixtime'), ts.Data)
xlabel(x_label)
ylabel(y_label)
print('-r300', strcat('figure - ', num2str(ii)), output_type)
end