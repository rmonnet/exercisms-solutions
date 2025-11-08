package tree

import "fmt"

type Record struct {
	ID     int
	Parent int
}

type Node struct {
	ID       int
	Children []*Node
	// Added ParentID so we can populate the parent Children field
    // from looping over the Nodes.
    ParentID int
}

func Build(records []Record) (*Node, error) {
    // Handle trivial case with no records.
    if len(records) == 0 {
        return nil, nil
    }
    // Collect all records into nodes, organize by ID.
    // We will populate the children list later.
	idToNode := map[int]*Node{}
    for _, record := range records {
        // Since all ids are consecutives and start at 0, the root node id must be 0
        if record.ID == record.Parent && record.ID != 0 {
            return nil, fmt.Errorf("Invalid root node with id %d", record.ID)
        }
        if record.ID < record.Parent {
            return nil, fmt.Errorf("Parent id (%d) is greater than record id (%d)",
                                   record.Parent, record.ID)
        }
        if record.ID < 0 || record.ID >= len(records) {
            return nil, fmt.Errorf("Record id (%d) not in valid bounds [0, %d)",
                                      record.ID, len(records))
        }
        if record.Parent < 0 || record.Parent >= len(records) {
            return nil, fmt.Errorf("Record parent id (%d) not in valid bounds [0, %d)",
                                      record.Parent, len(records))
        }
        if _, ok := idToNode[record.ID]; ok {
            return nil, fmt.Errorf("Duplicate record for id %d", record.ID)
        }
        idToNode[record.ID] = &Node{
            ID: record.ID, Children: []*Node{}, ParentID: record.Parent}
    }

    // Now build theChildren lists (using the Parent ID from each node).
    //
    // With all the checks above we are guarantied that we have a map (idToNode)
    // with all id numbers from 0 to len(records). We are also guaranties that
    // all parent ids are in the same range so there is no need to check when
    // accessing a node per id in idToNode.
    for id := 1; id < len(records); id++ {
        node := idToNode[id]
        parentNode := idToNode[node.ParentID]
        parentNode.Children = append(parentNode.Children, node)
    }

    return idToNode[0], nil
}
