function [seconds] = day2sec(datenumber)
% function [seconds] = day2sec(dates)
%
% This function will output the number of seconds that have elapsed since
% the first MATLAB datenumber in the input vector. The datenumber vector is
% already in the correct format of MATLAB datenumber and it is increasing
% monotonically.
%
% Input:
% datenumber - Vector of MATLAB datenumber (i.e. 2021/1/23 = 738,179 MATLAB
% datenumber)
%
% Output:
% seconds - Vector of seconds elapsed after the first date in the input
% vector

% days = datenum(dates); 
% To change to MATLAB time serial number - number 1 represents Jan 1 0000,
% and everything follows in increasing order from that date (don't have to
% convert to matlab datenum anymore)

datenumber = datenumber - datenumber(1);
% To change the time relative to the first date value in the input vector

seconds = datenumber*24*3600;
% To change the days into seconds

end