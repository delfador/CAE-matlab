function [y, z] = rebalance(x)
% REBALANCE
%
% Removes negative observations from a time series by transfering negative
% values backwards in time.
%
% Example:
%    y = rebalance([2 4 -2 3 2 -4 5])
% returns
%    y = [2 2 0 1 0 0 5]

% This is a debugging exercise and this function contains two
% implementations.  The first implementation is correct, and serves as a
% means to show you how the correct output should look like.
%                                                                          
% The second implementation contains bugs.  You should correct this
% implementation following the original idea with the indices of negative
% entries.
%                                                                          
% Make sure that your code works correctly for                             
%     [y,z] = rebalance([2 4 -2 3 2 -4 5])                                 
%     [y,z] = rebalance([2 4 -2 3 2 -4 -1])                                
%     [y,z] = rebalance([-2 4 -2 3 2 -4 5])                                

%% First "good" implementation

% Make sure we work with a column vector
z = x(:);
while any(z<0)
    % Keep positive parts, and move negative parts backwards
    z = max(z, 0) + [min(z(2:end), 0); 0];
end
% Convert to the original shape of x
z = reshape(z, size(x));



%% Second implementation with bugs
y = x;
i = find(y<0);
while ~isempty(i)
    % Move negative values back in time
    y(i-1) = y(i-1) + y(i);
    
    % Get rid of the negative entry
    y(i) = 0;

    i = find(y<0);
end
