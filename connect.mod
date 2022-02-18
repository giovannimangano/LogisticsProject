param Capacity;

set Nodes;

param balance{Nodes};
param sending{Nodes} >= 0;
param receiving{Nodes} >= 0; 


set Links within (Nodes cross Nodes);

param activationCost{Links} >= 0;
param variableCost{Links} >= 0;


var open{Links} binary;
var flow{Links} integer >=0;


minimize Costs:  sum{(i,j) in Links} (activationCost[i,j] * open[i,j] + variableCost[i,j] * flow[i,j]);

subject to capacitated{(i,j) in Links} : flow[i,j] <= Capacity * open[i,j];
subject to Send{j in Nodes} : sum{(i,j) in Links} flow[i,j] >= receiving[j];
subject to Recive{i in Nodes} : sum{(i,j) in Links} flow[i,j] >= sending[i];
subject to Conservation{j in Nodes} : sum{(i,j) in Links} flow[i,j] -  sum{(j,i) in Links} flow[j,i] == balance[j];
