package kindergarten

import "strings"
import "errors"
import "sort"

type Garden map[string][]string

const (
	errPlant = "Invalid plant given"
	errDiag = "Diagram length should be greater than 1 and start with EOL"
	errRow = "Diagram should contains two rows"
	errChild = "Child already exist"
	errInvalid = "Given diagram is invalid"
)

func parsePlants(plants []byte) ([]string, error) {
	ret := []string{}

	for _, b := range plants {
		switch b {
			case 'V': ret = append(ret, "violets")
			case 'R': ret = append(ret, "radishes")
			case 'C': ret = append(ret, "clover")
			case 'G': ret = append(ret, "grass")
			default: return nil, errors.New(errPlant)
		}
	}
	return ret, nil
}

func parseDiagram(diagram string, children int) ([]string, error) {
	if len(diagram) < 2 && diagram[0] != '\n' {
		return nil, errors.New(errDiag)
	}

	ret := strings.Split(diagram[1:], "\n")

	if len(ret) != 2 { return nil, errors.New(errRow) }
	
	if len(ret[0]) != len(ret[1]) || len(ret[0]) != children * 2 {
		return nil, errors.New(errInvalid)
	}

	return ret, nil
}


func NewGarden(diagram string, children []string) (*Garden, error) {
	process, err := parseDiagram(diagram, len(children))

	if err != nil { return nil, err }

	garden := Garden{}

	sortedChild := sort.StringSlice(append([]string{}, children...))
	sortedChild.Sort()

	for i, child := range sortedChild {
		getPlants := []byte{
			process[0][i * 2],
			process[0][i * 2 + 1],
			process[1][i * 2],
			process[1][i * 2 + 1],
		}

		p, err := parsePlants(getPlants)

		if err != nil { return nil, err }

		if _, ok := garden[child]; ok { return nil, errors.New(errChild) }

		garden[child] = p
	}
	return &garden, nil
}

func (g *Garden) Plants(child string) ([]string, bool) {
	v, ok := (*g)[child]; return v, ok
}
