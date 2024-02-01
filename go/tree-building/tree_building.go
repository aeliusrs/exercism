package tree

import "sort"
import "errors"

// Record represents a node before it is represented in a tree
type Record struct { ID, Parent int }

type Node struct { ID int; Children []*Node }

func Build(records []Record) (*Node, error) {
	if len(records) == 0 { return nil, nil }

	sort.Slice(records, func(i, j int) bool {
		return records[i].ID < records[j].ID
	})

	if records[0].ID != 0 || records[0].Parent != 0 {
		return nil, errors.New("Root must be id 0, parent 0")
	}

	nodes := make([]Node, len(records))
	for i, rec := range records {
		if rec.ID != i {
			return nil, errors.New("Records must be continuous")
		}

		if rec.ID != 0 && rec.ID <= rec.Parent {
			return nil, errors.New("Records must build tree")
		}

		nodes[i] = Node{ID: rec.ID}

		if rec.ID != 0 {
			nodes[rec.Parent].Children = append(nodes[rec.Parent].Children, &nodes[i])
		}
	}

	return &nodes[0], nil
}
