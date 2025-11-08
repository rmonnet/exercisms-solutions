package tree

import "fmt"


type Record struct {
	ID     int
	Parent int
	// feel free to add fields as you see fit
}

type Node struct {
	ID       int
	Children []*Node
	// feel free to add fields as you see fit
}

func Build(records []Record) (*Node, error) {
    // Handle trivial case with no records.
    if len(records) == 0 {
        return nil, nil
    }
    // Collect and check all records, organize by ID.
	idToRecord := map[int]Record{}
    rootID := -1
    for _, record := range records {
        fmt.Printf("- record: %#v\n", record)
        if record.ID == record.Parent {
            if rootID != -1 {
                return nil, fmt.Errorf("Found more than one root note, ids: %d and %d",
                                      rootID, record.ID)
            }
            rootID = record.ID
        }
        if record.ID < record.Parent {
            return nil, fmt.Errorf("Parent id (%d) is greater than record id (%d)",
                                   record.Parent, record.ID)
        }
        if record.ID < 0 || record.ID >= len(records) {
            return nil, fmt.Errorf("Record id (%d) not in valid bounds [0, %d)",
                                      record.ID, len(records))
        }
        if _, ok := idToRecord[record.ID]; ok {
            return nil, fmt.Errorf("Duplicate record for id %d", record.ID)
        }
        idToRecord[record.ID] = record
    }
    if rootID == -1 {
        return nil, fmt.Errorf("No root node found in input records")
    }
    
    idToNode := map[int]*Node{}
    for id := 0; id < len(records); id++ {
        record, ok := idToRecord[id]
        if !ok {
            return nil, fmt.Errorf("Missing record for id %d", id)
        }
        node := &Node{ID: id, Children: []*Node{}}
        idToNode[id] = node
        if record.ID != record.Parent {
            parentNode, ok := idToNode[record.Parent]
            if !ok {
                return nil, fmt.Errorf("Missing parent node (%d) for node id %d",
                                        record.Parent, record.ID)
            }
            parentNode.Children = append(parentNode.Children, node)
    	}
    }

    return idToNode[rootID], nil
}
