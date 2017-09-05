%We use the import data interface on the home above to import data from the
%tables

MASS(isnan(MASS)) = [];
MASS = sort(MASS);
mini = min(MASS);
maxi = max(MASS);
%csvwrite('ONCmass',MASS);%this is da rio data set from
ONC = Mass;
ONC(ONC(:)==-9.99) = [];
ONC = sort(ONC);
[n,m] = size(ONC); 
j = 1;
k= 1;
for i = 1:n 
    if ONC(i)<= 3.0
        below3solar(j,1) = ONC(i);
        j = j+1;
    else
        above3solar(k,1) = ONC(i);
        k = k+1;
    end
end


ONCdata = [MASS;above3solar];
csvwrite('ONCdata',ONCdata);