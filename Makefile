all: generator edge node

generator: generator.cpp 
	g++ generator.cpp -o generator
edge: edge.cpp 
	g++ edge.cpp -o edge
node: node.cpp
	g++ node.cpp -o node

clean:
	rm -f alllake.txt allriver.txt allsea.txt rl.txt rr.txt rs.txt rrEdge rlEdge rsEdge rr rl rs riverNode seaNode lakeNode lake.txt river.txt sea.txt generator edge node graph.gv
	
