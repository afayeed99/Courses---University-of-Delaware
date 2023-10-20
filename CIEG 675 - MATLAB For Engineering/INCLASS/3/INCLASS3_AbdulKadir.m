%% CIEG 675 - Matlab For Engineering Analysis (In Class 3)
% * All parts of the problems are combined into one coding (no separate
% sections)
% * Opening and closing of file are done once

fid = fopen('BM_dem_ascii.txt','r');
% Open the file and to read 'r'; assign to fid -> id number

for i = 1:5 % To read the first five lines
    metadata{i} = fgetl(fid); % Assign each line to cell array
    [title_name{i},remain{i}] = strtok(metadata{i});
    % Split the string by default (separated from the first spacing)
    [actual_data{i},spaces{i}] = strtok(remain{i});
    % The remain above contains the actual data, but it still has spaces
    % Doing this twice to remove the space; since the beg. has spaces, it
    % will just skip to the number we want and assign to first var.
end

actualdata = str2double(actual_data); % Convert string to number

[ncols,nrows,xllcorner,yllcorner,cellsize] = ...
    deal(actualdata(1),actualdata(2),actualdata(3),actualdata(4),actualdata(5));
% Assigning the numbers to their respective variables; use deal to do this
% at once

junk = fgetl(fid); % To acquire the 6th line (don't bother to close and reopen)

elevation_data = textscan(fid,repmat('%f',1,ncols));
% The elevation data is the rest of the numbers in the txt
% textscan automatically read by however format we want, i.e. %f%f%f... and
% will by default assume the rest to be on the next line (if there's any left)
% Since we want it to read the first row (line) by ncols times, use repmat
% to replicate the word '%f' by ncols times: repmat('%f',1,3) == '%f%f%f'
% This whole thing does not require loop to go over to the next line or the
% necessity of using '\n', it does this automatically

BM = cell2mat(elevation_data); % Convert the cell array to matrix
fclose(fid); % Close the file

x = xllcorner:cellsize:xllcorner + (ncols - 1)*cellsize; 
y = yllcorner:cellsize:yllcorner + (nrows - 1)*cellsize;
% Arithmetic sequence of #, starting from x/yllcorner
% a_n = a_0 + (n-1)*diff

s(1) = subplot(1,2,1);
pcolor(x - x(1), y - y(1), BM); shading flat;
% pcolor(X,Y,Z), and this is corrected to make x(1) and y(1) == 0
colorbar; caxis([-3 2.5])
xlabel('x (m)'); ylabel('y (m)'); title('\bf Original Data');
% 'bf' means bold font (shorter way than 'fontweight','bold')

BM_mod = BM;
index_below0 = find(BM_mod <= 0); 
BM_mod(index_below0) = NaN; % Assigning elevation <= 0 to NaN

limits = [get(s(1), 'xlim') get(s(1), 'ylim')]; 
% To acquire the limits on first subplot
s(2) = subplot(1,2,2);
pcolor(x - x(1), y - y(1), BM_mod); shading flat
colorbar; caxis([-3 2.5]); axis(limits) % To have same axis as first plot
xlabel('x (m)'); ylabel('y (m)'); title('\bf Elevations > 0 Only')
set(gcf,'position',[258 99 947 638]) % To make figure bigger

print -dtiff -r600 Elevation_Plot