% this matlab command show the representation of graph with in form of 
% adjancary matrix and performing the bfs algorithm on it.
% To show the image of graph rum following command. 

showimage(which('graph.png'))

%n = input('Enter the no. of Nodes in the graph : ');
m
G = zeros(n);

G(1,2) = 1; 
G(1,3) = 1;
G(2,1) = 1;
G(3,1) = 1;
G(3,4) = 1;
G(3,8) = 1;
G(4,3) = 1;
G(4,5) = 1;
G(4,6) = 1;
G(4,7) = 1;
G(5,4) = 1;
G(6,4) = 1;
G(6,9) = 1;
G(7,4) = 1;
G(8,3) = 1;
G(8,9) = 1;
G(9,8) = 1;
G(9,6) = 1; 


G = sparse(G);
visited = zeros(9,1);
%%% starting from any vertex say i == 0 and scan the edge incident on it. 

start_vertex = 1;

dfs_search = bfs(start_vertex);



function dfs(n)

fprintf('%i\n', n);

for i=1:9 
    if G(start_vertex,i) == 1
        




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bfs_queue = [];
component_01_lvl_00 = [];
component_01_lvl_01 = [];
marked_vertices = [start_vertex];
for k = 1:9 
    if (length(marked_vertices))<=9


        for j=1:9 
            if G(start_vertex,j) == 1
                bfs_queue = [bfs_queue, j] 
            end 
        end
     
        component_01_lvl_00 = [component_01_lvl_00, start_vertex] ;
        component_01_lvl_01 = [component_01_lvl_01, bfs_queue];
    
        child_of_component_01_lvl_00 = component_01_lvl_01;
        parent_of_component_01_lvl_01 = component_01_lvl_00;
     
     
        marked_vertices = [marked_vertices, component_01_lvl_01];
    
        start_vertex = bfs_queue(1)
    end 
     
end  
     
    
     


































