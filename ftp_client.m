function ftp_client(subject_id, topic_name, target_folder)
% For downloading all the topics use '*'
%
% Created by Yatharth Ranjan on 05/02/2018

% TODO Also create a function to get files of a specific time period

% Change according to your credentials
host = '<your_ip>';
username = '<your_username>';
password = '<your_password>';

root_path = '/RADAR-CNS/HDFS_CSV/output'

ftp_obj = ftp(host,username,password);

remote_folder = sprintf('%s/%s/%s',root_path,subject_id,topic_name);
mget(ftp_obj, remote_folder, target_folder);

dir(ftp_obj, root_path);

close(ftp_obj);

end
