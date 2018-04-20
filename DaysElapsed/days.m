function nd = days(mo, da, leap)
%days Returns the number of days that have elapsed since the beginning of
%the year for the given inputs
%
%Inputs:
%   Month - Number between 1 and 12
%   Days - Between 1 and 31
%   Leap Year Y/N - 1 if Yes, 0 if No
%Outputs:
%   Number of days elapsed until that point

%Days in each month
DaysInMonth = [31 28 31 30 31 30 31 31 30 31 30 31];

%Days in each month that was fully elapsed + days in current month elapsed
nd = sum(DaysInMonth(1:mo-1))+da;

if(mo > 2)%if past febuary
    nd = nd + leap;%add leap day if leap year
end

end

