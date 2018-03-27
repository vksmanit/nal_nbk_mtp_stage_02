function nodeInfo = ckt_node_connection_info(circuitdata)
% function nodeInfo = ckt_node_connection_info(cktnetlist)
% return node connection information along with name, elements,connection
% 
% Enter 'nodeInfo{:}' to see the conncetion, without 'colon'


%%%%%%%%%%%%%%%%%%%%%%%% August 24, 2017 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Author : Vipin Kumar Soni %%%%%%%%%%%%%%%%%%%%%%%

    for i = 1:length(circuitdata.nodenames)

        nodeInfo{i}.name = circuitdata.nodenames(i);
        for j = 1 : length(circuitdata.elements)
            nodeInfo{i}.connection{j} = strcmp (nodeInfo{i}.name, circuitdata.elements{j}.nodes); 
            nodeInfo{i}.elements{j}   = circuitdata.elements{j}.name ; %% can we optimize here
        end
    end
end 
