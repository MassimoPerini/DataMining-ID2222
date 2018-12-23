clc;clear all;close all;

%Initialisation :

%sigma=30;                                    %Choose the tightest value
K=4;                                         %K = number of clusters for k-means
% K = 4 for example 1, K = 2 for example 2 according to the visualisation
data = csvread('example1.dat');      % Choose the dataset


% First Step



% Creation of the affinity matrix according to the given formula 

% for i=1:length(data(:,1))
%     for j=1:length(data(:,1))
%     if i==j
%         A(i,j)=0;
%     else
%         A(i,j)=exp(-((data(i,1)-data(j,1))^2+(data(i,2)-data(j,2))^2)^(0.5)/(2*sigma^2));
%     end
%     end
% end

% Since there is no weight on the edges, the distances is always equal to 1
% We can use a simple adjacency matrix to compute the affinity matrix

col1 = data(:,1);
col2 = data(:,2);

G = graph( col1, col2 );
A = adjacency(G);   % Computation of the adjacency matrix
G = graph(A);
G.Edges;


A = full(A); % To not have a sparse matrix
spy(A,'r'); % Visualization of the sparsity pattern



% Second step 

D=diag(sum(A,2));           %Diagonal matrix
L=D^(-1/2)*A*D^(-1/2);

Laplacian = D-A;

% Third step

[eigVecsK,eigValsK] = eigs(L,K,'la');
diag(eigValsK)  


% Fourth step

denom  =(sum( eigVecsK.^2,2)).^(1/2);
%normalize
Y = bsxfun(@rdivide,eigVecsK,denom);


% Fifth step

[idx,C] = kmeans(Y,K,'MaxIter',100);


% Plot
%kmeans clustering

% Visualization of the different clusters

[idx,C] = kmeans(Y,K,'MaxIter',100);
size(idx)
idx;
figure;
hold on;
h = plot(G);
highlight(h,find(idx==1),'NodeColor','r')
highlight(h,find(idx==2),'NodeColor','g')
highlight(h,find(idx==3),'NodeColor','b')
highlight(h,find(idx==4),'NodeColor','c')


% Visualization of the Sorted Fiedler Vector

[eigVecs,eigVals] = eig(Laplacian);
sort(diag(eigValsK))

eigVec = eigVecs(:,K); %if k=1 this would be the fieldler vector.
sorted_vec = sort(eigVec);
figure;
plot(sorted_vec)

