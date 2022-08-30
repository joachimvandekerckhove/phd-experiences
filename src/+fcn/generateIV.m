function data = generateIV(data)

data.IV = nan(size(data.group));

data.IV(ismember(data.Person, data.Person(data.group==1))) = 1;
data.IV(ismember(data.Person, data.Person(data.group==2))) = 2;
data.IV(ismember(data.Person, data.Person(data.group==3))) = 2;
data.IV(ismember(data.Person, data.Person(data.group==4))) = 2;
data.IV(ismember(data.Person, data.Person(data.group==5))) = 3;

end