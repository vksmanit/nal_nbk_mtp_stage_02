function cktnetlist = graph_info_ckt_01()
% (1) following function will give the cktnetlist represented by figure given by ************ add figure
% cktnetlsit = graph_info_ckt_01()

%%%%%%%%% Date : Aug 23, 2017 %%%%%%%%%%%%
%%%%%%%%%%% Vipin Kumar Soni %%%%%%%%%%%%%

    clear cktnetlist;
    cktnetlist.cktname = 'graph_info_ckt_01';
    cktnetlist.nodenames = {'node_1','node_2','node_3'};
    cktnetlist.groundnodename = 'gnd';

    
    rM = resModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();
    cM = capModSpec();

    cktnetlist = add_element(cktnetlist, rM, 'R1', {'node_1','gnd'}, {{'R', 1e3}});
    cktnetlist = add_element(cktnetlist, rM, 'R2', {'node_1','node_2'}, {{'R', 2e3}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'node_2','node_3'}, {{'R', 1e3}});
    cktnetlist = add_element(cktnetlist, cM, 'C1', {'node_2', 'gnd'}, {{'C',1e-6}});
    cktnetlist = add_element(cktnetlist, cM, 'C2', {'node_3', 'gnd'}, {{'C',2e-6}});
    cktnetlist = add_element(cktnetlist, iM, 'I2', {'node_3', 'gnd'}, {},{{'DC',1e-3}});
    cktnetlist = add_element(cktnetlist, vM, 'V1', {'node_1','gnd'}, {}, {{'DC',1}});
    

end  
